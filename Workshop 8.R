# Workshop 8 - Data Visualisation 1
# Personal tokem - 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
# 12/03/2024

# Section 2 - The Grammaer of Graphics
 # Geoms - Geometric objects that display our data (geom_point)
 # Aesthetics - Features of the geoms (positioned along the x and y axis - shape, size and colour)

install.packages("palmerpenguins")
library(palmerpenguins)
install.packages("tidyverse")
library(tidyverse)

# CREATE A SCATTERPLOT TO LOOK FOR A CORRELATION BETWEEN BODY MASS AND LENGTH
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g))
 # ggplot - Creates a base plot specifying the data set
 # mapping = ase - Specifies mapping of variables to aesthetic attributes (position/size/colour) of the points
 # geom_points adds a scatterplot to the base plot specifying the aesthetic mappings

# ADDING COLOUR TO THE SPECIES POINTS
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g, colour = species))
 # Mapping the colour of the points to the variables species

# Question 1 - Does this cluster also correlate with the island the penguins are from? Copy and change the code above to check.
# ADD COLOUR TO THE ISLAND POINTS
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g, colour = island))

# Can add aditional laters to our plots by specifying additional geoms
# ADD A SMOOTH LINE TO THE PLOTS
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_smooth(mapping = aes(x = bill_length_mm, y = body_mass_g))

# CREATE A CURVE FOR ALL THREE SPECIES RATHER THE ONE CURVE ACROSS ALL THREE
ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species)) +
  geom_smooth()
 # This code still creates a curve across all 3 species because no additional aesthetic mappings are specific in geom_smooth so it inherits the mappings from the (ggplot())
 # Uses bill_length_mm on the x axis and body_mass_g on the y axis to centre the smooth line
 # Does not use the colour mapping from geom_point() because inheritance occurs at the level of the ggplot()

# CORRECT THE CODE BY MAPPING THE COLOUR AESTHETIC TO GEOM_SMOOTH
ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species)) +
  geom_smooth(mapping = aes(colour = species))

# ASSIGN THE PLOT TO A VARIABLE TO MAKE CHANGES LATER
 # Allows to save a basic plot and try out different layers or other motifcations
pengu_plot <-
  ggplot(data = penguins,
         mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(aes(colour = species))
#We can add layers to our plot
pengu_plot +
  geom_smooth()

# QUESTION 2 - Write code to produce the following plot. Hint: Look at the documentation for geom_smooth to find the arguments you need for a linear model and to remove the confidence intervals.
 # CREATE A LINEAR MODEL FOR BILL LENGTH AND DEPTH AND REMOVE CONFIDENCE LEVELS
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(mapping = aes(colour = species, shape = species)) +
  geom_smooth(mapping = aes(colour = species),
              method = "lm",
              se = FALSE)

# CREATE A CLEANER CODE
ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = boss_mass_g)) +
  geom_point() +
  geom_smooth()
 # if same variable mappings are used, they only need to be mentioned on ggplot

# Section 3 - Saving Plots
 # SAVE PLOTS TO A FILE USING GGSAVE
ggsave(filename = "penguin_plot_1.png", plot = pengu_plot)
 # If you don't pass it a variable, it will save the last plot we printed to screen
 ## ggsave("penguin_plot_2.png")

# CHANGE THE DIMENSIONS OF THE PLOT WITH MODEL LINES AS 200mm X 300mm png.
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(mapping = aes(colour = species, shape = species)) +
  geom_smooth(mapping = aes(colour = species),
              method = "lm",
              se = FALSE)

ggsave("penguin_plot_3.png",width=300,height=200,units="mm")

# Section 4 - Continuous versus categorical variables
 # CREATE A BOXPLOT TO INVESTIGATE BODY MASS FOR EACH SPECIES
ggplot(data = penguins,
       mapping = aes(x = species, y = body_mass_g)) +
  geom_boxplot(mapping = aes(colour = species))

# FILL THE BOXES WITH COLOUR INSTEAD OF AN OUTLINE
ggplot(data = penguins,
       mapping = aes(x = species, y = body_mass_g)) +
  geom_boxplot(mapping = aes(fill = species))

penguins_2 <- penguins
penguins_2$species <- 
  factor(penguins_2$species, levels = c("Chinstraps", "Gentoo", "Adelie"))

ggplot(data = penguins_2, 
       mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(mapping = aes(fill = island))

# penguins_2 - Creates copy of 'penguins' dataset
# converts species column to a factor variable
# levels are specified as "Chinstrap", "Gentoo" and the "Adelie" to ensure they are ordered correctly
# geom_violin - Creates a violin plot, showing the probability density of the data at different values

# Section 5 - Statistical transformations
 # CREATE A HORIZONTAL BAR PLOT
ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species)) +
  coord_flip()
 # geom_bar - Creates bars
 # x axis - Mapped to the species variable, meaning each unique species will have it's own bar
 # coord_flip - Modifies the coordinate system of the plot, flipping the orientation from vertical to horizontal

# QUESTION 3 - Have a look at the documentation for geom_bar. What is the difference between geom_bar() and geom_col()? Also, what does coord_flip() do?
# QUESTION 4 - Have a close look at the plots below. What is the difference? Can you find the geom to reproduce these plots and the geom argument to switch between the two? Bonus credit: The bars are slightly transparent. Can you find the argument to change transparency?
 # CREATE A 50% TRANSPARENT HISTOGRAM OF THR FLIPPER LENGTHS OF PENGUINS
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm)) +
  geom_histogram(aes(fill = species), position = "identity", alpha = 0.5) #change position to "stack" for plot on right
 # position = "identify' - Specifies that the bars should be places directly on top of each other
 # aes(fill = species) - Maps the species varaibles to the fill asetheitc
 # alpha = 0.5 - Sets the transparency of the bars to 50% (semi-transparent)

# CREATE POSITION TO STACK
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm)) +
  geom_histogram(aes(fill = species), position = "stack", alpha = 0.5)
  # position = "stack" - The bars should be stacked directtly on top of each other
  # To make the bars more visible/vistabliy segmented by species

# Section 6 - Plotting only a subset of your data: fitler()
# CREATE A SCATTER PLOT OF FLIPPER LENGTH FOR TWO SPECIES ONLY
penguins %>% filter(!species == "Chinstrap") %>%
  ggplot(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species, shape = island))
# NOTES - Use + instead of %>% when adding layers top the plot
# filter - filters the penguins dataset to exclude rows where the species is "Chinstrap"

# REPRODUCE THE PLOT WITHOUT NA'S - ONLY CONTAINING PENGIUNS WHERE SEX IS KNOWN
penguins %>% # filter(!is.na(sex)) %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex))

# Section 7 - Labels
# CREATE A VIOLIN PLOT OF BODY MASS INCLUDUNG TITLE, LABELS AND A CAPTION
penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Weight distribution among penguins",
       subtitle = "Plot generated by E. Busch-Nentwich, March 2023",
       x = "Species",
       y = "Weight in g",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  )

# CHANGE THE LEGEND LABELS
penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Weight distribution among penguins",
       subtitle = "Plot generated by E. Busch-Nentwich, March 2023",
       x = "Species",
       y = "Weight in g",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  ) +
  scale_fill_discrete(name = "Sex",
                      labels = c("Female", "Male", "Unknown"),
                      type = c("yellow3", "magenta4", "grey"))
# scale_fill_discrete() with the specificed arguments will customize the fill scale of the violin plot
# name - Sets the title for the legend 
# type - Specifies the colours for each category
# arrange() - Allows you yo sort rows by values in one or more columns

# Section 8 - The big challage
#Reading in file
modeltab <- read.table("wmr_modelling.txt",sep="\t",header=T)

#Filter for 2020 and reorder in deaths order
modeltab20 <- modeltab %>% filter(year == 2020) %>% arrange(deaths)

#Make countries factors in the order of deaths
deathorder20 <- modeltab20$country
modeltab20$country <- factor(modeltab20$country, levels = deathorder20)

#Plot data
ggplot(modeltab20, aes(x = country, y = deaths)) +
  geom_col() +
  coord_flip() +
  labs(title = "Malaria Deaths in 2020")

















