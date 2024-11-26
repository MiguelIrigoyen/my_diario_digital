// Clase principal para gestionar favoritos y etiquetas
    public class FavoritosEtiquetas
    {
        private readonly List<Entrada> entradasFavoritas;
        private readonly Dictionary<int, List<string>> etiquetasPorEntrada;
        private readonly DatabaseContext dbContext;

        public FavoritosEtiquetas()
        {
            entradasFavoritas = new List<Entrada>();
            etiquetasPorEntrada = new Dictionary<int, List<string>>();
            dbContext = new DatabaseContext();
        }

        public void MarcarFavorito(int idEntrada)
        {
            try
            {
                var entrada = dbContext.Entradas.Find(idEntrada);
                if (entrada != null)
                {
                    entrada.EsFavorito = !entrada.EsFavorito;
                    dbContext.SaveChanges();
                    
                    if (entrada.EsFavorito)
                        entradasFavoritas.Add(entrada);
                    else
                        entradasFavoritas.RemoveAll(e => e.Id == idEntrada);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al marcar favorito: {ex.Message}", "Error", 
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        public List<Entrada> VerFavoritos()
        {
            try
            {
                return dbContext.Entradas
                    .Where(e => e.EsFavorito)
                    .OrderByDescending(e => e.FechaCreacion)
                    .ToList();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al obtener favoritos: {ex.Message}", "Error", 
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                return new List<Entrada>();
            }
        }

        public void AgregarEtiqueta(int idEntrada, string etiqueta)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(etiqueta))
                    throw new ArgumentException("La etiqueta no puede estar vacía");

                var entrada = dbContext.Entradas.Find(idEntrada);
                if (entrada != null)
                {
                    var nuevaEtiqueta = new Etiqueta
                    {
                        EntradaId = idEntrada,
                        Nombre = etiqueta.Trim().ToLower(),
                        FechaCreacion = DateTime.Now
                    };

                    dbContext.Etiquetas.Add(nuevaEtiqueta);
                    dbContext.SaveChanges();

                    // Actualizar el diccionario local
                    if (!etiquetasPorEntrada.ContainsKey(idEntrada))
                        etiquetasPorEntrada[idEntrada] = new List<string>();
                    
                    etiquetasPorEntrada[idEntrada].Add(etiqueta);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al agregar etiqueta: {ex.Message}", "Error", 
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        public List<Entrada> BuscarPorEtiqueta(string etiqueta)
        {
            try
            {
                return dbContext.Entradas
                    .Where(e => e.Etiquetas.Any(et => et.Nombre == etiqueta.ToLower()))
                    .OrderByDescending(e => e.FechaCreacion)
                    .ToList();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error al buscar por etiqueta: {ex.Message}", "Error", 
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                return new List<Entrada>();
            }
        }
    }

   

 // Clase para representar una entrada en el diario
    public class Entrada
    {
        public int Id { get; set; }
        public string Titulo { get; set; }
        public string Contenido { get; set; }
        public DateTime FechaCreacion { get; set; }
        public bool EsFavorito { get; set; }
        public virtual ICollection<Etiqueta> Etiquetas { get; set; }
    }

    // Clase para representar una etiqueta
    public class Etiqueta
    {
        public int Id { get; set; }
        public int EntradaId { get; set; }
        public string Nombre { get; set; }
        public DateTime FechaCreacion { get; set; }
        public virtual Entrada Entrada { get; set; }
    }

    // Clase para el contexto de la base de datos
    public class DatabaseContext : DbContext
    {
        public DbSet<Entrada> Entradas { get; set; }
        public DbSet<Etiqueta> Etiquetas { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Entrada>()
                .HasMany(e => e.Etiquetas)
                .WithOne(t => t.Entrada)
                .HasForeignKey(t => t.EntradaId);
        }
    }

    // Formulario Windows Forms para la interfaz de usuario
    public partial class FormFavoritosEtiquetas : Form
    {
        private readonly FavoritosEtiquetas favoritosEtiquetas;
        private readonly ListView listViewEntradas;
        private readonly TextBox txtEtiqueta;
        private readonly Button btnAgregarEtiqueta;
        private readonly Button btnBuscarEtiqueta;

        public FormFavoritosEtiquetas()
        {
            InitializeComponent();
            favoritosEtiquetas = new FavoritosEtiquetas();

            // Configuración del ListView
            listViewEntradas = new ListView
            {
                Dock = DockStyle.Fill,
                View = View.Details,
                FullRowSelect = true,
                GridLines = true
            };
            listViewEntradas.Columns.Add("Título", 200);
            listViewEntradas.Columns.Add("Fecha", 100);
            listViewEntradas.Columns.Add("Etiquetas", 200);

            // Configuración de controles
            txtEtiqueta = new TextBox { Width = 150 };
            btnAgregarEtiqueta = new Button { Text = "Agregar Etiqueta" };
            btnBuscarEtiqueta = new Button { Text = "Buscar por Etiqueta" };

            // Eventos
            btnAgregarEtiqueta.Click += BtnAgregarEtiqueta_Click;
            btnBuscarEtiqueta.Click += BtnBuscarEtiqueta_Click;
            listViewEntradas.DoubleClick += ListViewEntradas_DoubleClick;

            // Cargar favoritos iniciales
            CargarFavoritos();
        }

        private void CargarFavoritos()
        {
            listViewEntradas.Items.Clear();
            var favoritos = favoritosEtiquetas.VerFavoritos();

            foreach (var entrada in favoritos)
            {
                var item = new ListViewItem(entrada.Titulo);
                item.SubItems.Add(entrada.FechaCreacion.ToShortDateString());
                item.SubItems.Add(string.Join(", ", entrada.Etiquetas.Select(e => e.Nombre)));
                item.Tag = entrada.Id;
                listViewEntradas.Items.Add(item);
            }
        }

        private void BtnAgregarEtiqueta_Click(object sender, EventArgs e)
        {
            if (listViewEntradas.SelectedItems.Count > 0)
            {
                var idEntrada = (int)listViewEntradas.SelectedItems[0].Tag;
                favoritosEtiquetas.AgregarEtiqueta(idEntrada, txtEtiqueta.Text);
                CargarFavoritos();
            }
        }

        private void BtnBuscarEtiqueta_Click(object sender, EventArgs e)
        {
            listViewEntradas.Items.Clear();
            var entradasFiltradas = favoritosEtiquetas.BuscarPorEtiqueta(txtEtiqueta.Text);

            foreach (var entrada in entradasFiltradas)
            {
                var item = new ListViewItem(entrada.Titulo);
                item.SubItems.Add(entrada.FechaCreacion.ToShortDateString());
                item.SubItems.Add(string.Join(", ", entrada.Etiquetas.Select(e => e.Nombre)));
                item.Tag = entrada.Id;
                listViewEntradas.Items.Add(item);
            }
        }

        private void ListViewEntradas_DoubleClick(object sender, EventArgs e)
        {
            if (listViewEntradas.SelectedItems.Count > 0)
            {
                var idEntrada = (int)listViewEntradas.SelectedItems[0].Tag;
                favoritosEtiquetas.MarcarFavorito(idEntrada);
                CargarFavoritos();
            }
        }
    }

