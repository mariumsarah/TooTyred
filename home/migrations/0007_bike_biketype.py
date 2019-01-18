# Generated by Django 2.1.5 on 2019-01-18 04:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('home', '0006_station'),
    ]

    operations = [
        migrations.CreateModel(
            name='Bike',
            fields=[
                ('bike_id', models.AutoField(primary_key=True, serialize=False)),
                ('travel_count', models.DecimalField(decimal_places=2, max_digits=8)),
                ('bike_status', models.CharField(max_length=12)),
            ],
            options={
                'db_table': 'bike',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='BikeType',
            fields=[
                ('biket_id', models.AutoField(primary_key=True, serialize=False)),
                ('bike_info', models.CharField(max_length=100)),
                ('bike_model', models.CharField(max_length=20)),
                ('bike_type', models.CharField(max_length=20)),
                ('bike_cost', models.DecimalField(decimal_places=2, max_digits=11)),
                ('bike_image', models.CharField(max_length=30)),
            ],
            options={
                'db_table': 'bike_type',
                'managed': False,
            },
        ),
    ]