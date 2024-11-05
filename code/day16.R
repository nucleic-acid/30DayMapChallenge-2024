# A not too serious election-related map
# **************************************

# load packages
library("ggplot2")
library("dplyr")
library("rnaturalearth")
library("rnaturalearthdata")
library("rcartocolor")
library("ggtext")
library("systemfonts")

# load world map data
world_map <- ne_countries(scale = "small", returnclass = "sf") |> 
  mutate(is_USA = iso_a3 == "USA")

# define colour palette
map_colors <- rcartocolor::carto_pal(n = 3, "Vivid")

# plot the map
ggplot(data = world_map) +
  geom_sf(aes(fill = is_USA), size = 0.1) +
  coord_sf() +
  scale_fill_manual(values = map_colors[c(1, 3)]) +
  theme_void() +
  labs(
    title = "Don't mess this up",
    subtitle = "Countries **other than the USA** holding their breath tonight. Nations {.orange **affected by today's election**} are coloured in orange, countries {.purple **not affected**} are shown in purple, USA in grey.",
  caption = "Base map via {rnaturalearth}, christiangebhard.com"
  ) +
  theme(
    text = element_text(family = "Archivo", size = 14),
    plot.title = element_markdown(family = "Archivo", face = "bold"),
    plot.subtitle = marquee::element_marquee(
      hjust = 0,
      width = unit(14, "cm"), # manually adjusted width
      style = marquee::classic_style(align = "left")
    ),
    legend.position = "none"
  )

ggsave(filename = "/path/to/output/day16.png",
       dpi = 300,
       height = 6, width = 6,
       bg = "#FFFFFF")  
