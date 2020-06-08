using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace com.Synjonse.Model.Models2
{
    public partial class HkTempContext : DbContext
    {
        public HkTempContext()
        {
        }

        public HkTempContext(DbContextOptions<HkTempContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Aa> Aa { get; set; }
        public virtual DbSet<Aset> Aset { get; set; }
        public virtual DbSet<Course> Course { get; set; }
        public virtual DbSet<Grade> Grade { get; set; }
        public virtual DbSet<Mset> Mset { get; set; }
        public virtual DbSet<Rset> Rset { get; set; }
        public virtual DbSet<Score> Score { get; set; }
        public virtual DbSet<Student> Student { get; set; }
        public virtual DbSet<Teacher> Teacher { get; set; }
        public virtual DbSet<Uset> Uset { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
//#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=.;database=HkTemp;Trusted_Connection=True;");
            }
        }
        //插入视图 dbs实体类
        public DbQuery<dbs> dbs { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //插入视图 dbs实体类
            modelBuilder.Query<dbs>().ToView("dbs");
            modelBuilder.Entity<Aa>(entity =>
            {
                entity.ToTable("AA");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Address)
                    .IsRequired()
                    .HasColumnName("address")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Age).HasColumnName("age");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Sex)
                    .IsRequired()
                    .HasColumnName("sex")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .IsFixedLength();
            });

            modelBuilder.Entity<Aset>(entity =>
            {
                entity.HasKey(e => e.Aid)
                    .HasName("PK__Aset__DE508E2E2FA9F46B");

                entity.Property(e => e.Aid).HasColumnName("aid");

                entity.Property(e => e.Mid).HasColumnName("mid");

                entity.Property(e => e.Pid).HasColumnName("pid");
            });

            modelBuilder.Entity<Course>(entity =>
            {
                entity.HasKey(e => e.Cno)
                    .HasName("PK_Cno");

                entity.HasIndex(e => e.Cname)
                    .HasName("UQ_Cname")
                    .IsUnique();

                entity.Property(e => e.Cno)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Cname)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Tno)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Grade>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("grade");

                entity.Property(e => e.Low).HasColumnName("low");

                entity.Property(e => e.Ranks)
                    .HasColumnName("ranks")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .IsFixedLength();

                entity.Property(e => e.Upp).HasColumnName("upp");
            });

            modelBuilder.Entity<Mset>(entity =>
            {
                entity.HasKey(e => e.Mid)
                    .HasName("PK__Mset__DF5032EC060167C7");

                entity.Property(e => e.Mid).HasColumnName("mid");

                entity.Property(e => e.Mname)
                    .IsRequired()
                    .HasColumnName("mname")
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Rset>(entity =>
            {
                entity.HasKey(e => e.Pid)
                    .HasName("PK__Rset__DD37D91A25721B61");

                entity.Property(e => e.Pid).HasColumnName("pid");

                entity.Property(e => e.Pnanme)
                    .IsRequired()
                    .HasColumnName("pnanme")
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Score>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.Cno)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Degree).HasColumnType("decimal(18, 0)");

                entity.Property(e => e.Sno)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Student>(entity =>
            {
                entity.HasKey(e => e.Sno)
                    .HasName("PK_Sno");

                entity.Property(e => e.Sno)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Class)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Sbirthday).HasColumnType("datetime");

                entity.Property(e => e.Sname)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Ssex)
                    .IsRequired()
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .IsFixedLength();
            });

            modelBuilder.Entity<Teacher>(entity =>
            {
                entity.HasKey(e => e.Tno)
                    .HasName("PK_Tno");

                entity.Property(e => e.Tno)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Depart)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Prof)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Tbrithday).HasColumnType("datetime");

                entity.Property(e => e.Tname)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Tsex)
                    .IsRequired()
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .IsFixedLength();
            });

            modelBuilder.Entity<Uset>(entity =>
            {
                entity.HasKey(e => e.Uid)
                    .HasName("PK__Uset__DD701264F9702F02");

                entity.Property(e => e.Uid).HasColumnName("uid");

                entity.Property(e => e.Aid).HasColumnName("aid");

                entity.Property(e => e.Uname)
                    .IsRequired()
                    .HasColumnName("uname")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Unames)
                    .IsRequired()
                    .HasColumnName("unames")
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Upwd)
                    .IsRequired()
                    .HasColumnName("upwd")
                    .HasMaxLength(20)
                    .IsUnicode(false);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
