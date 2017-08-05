lcbo_yml = File.new(Rails.root.join("config/lcbo.yml")).read
LCBO_CREDS = YAML.load(ERB.new(lcbo_yml).result)[Rails.env]
LCBO_KEY = LCBO_CREDS['api_key']
LCBO_URL = LCBO_CREDS['api_url']