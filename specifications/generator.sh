# generate Author model
rails g model Author last_name:string first_name:string email:string password_digest:string admin?:boolean

# generate Lemma model:
rails g model Lemma lemma:string lexical_category:string class:string irregularity:string origin:string

# generate Story model:
rails g model Story story_title:string story:text author:references{index}

# generate StoryLemma model
rails g model StoryLemma gloss:string lemma:belongs_to{index} story:belongs_to{index}
