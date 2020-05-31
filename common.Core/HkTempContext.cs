using System;
using com.Synjonse.Model.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;


namespace common.Core
{
    public partial class HkTempContext : DbContext
    {
        public override int SaveChanges()
        {
            return base.SaveChanges(true);
        }
        public HkTempContext()
        {
        }

        public HkTempContext(DbContextOptions<HkTempContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Aa> Aa { get; set; }
        public virtual DbSet<Course> Course { get; set; }
        public virtual DbSet<Student> Student { get; set; }
        public virtual DbSet<Teacher> Teacher { get; set; }

        // Unable to generate entity type for table 'dbo.Score'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.grade'. Please see the warning messages.

//        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
//        {
//            if (!optionsBuilder.IsConfigured)
//            {
//#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
//                optionsBuilder.UseSqlServer("server=.;database=HkTemp;uid=sa;pwd=123;");
//            }
//        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.4-servicing-10062");

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
                    .IsUnicode(false);
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
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Cname)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Tno)
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
                    .IsUnicode(false)
                    .ValueGeneratedNever();

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
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Teacher>(entity =>
            {
                entity.HasKey(e => e.Tno)
                    .HasName("PK_Tno");

                entity.Property(e => e.Tno)
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

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
                    .IsUnicode(false);
            });
        }
    }
}
