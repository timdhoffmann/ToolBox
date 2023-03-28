use std::error::Error;
use std::{env, fs};

pub struct Config {
    pub query: String,
    pub file_path: String,
    pub is_case_sensitive: bool,
}

impl Config {
    pub fn build(args: &[String]) -> Result<Config, &'static str> {
        if args.len() < 3 {
            return Err("Missing minimum required arguments.");
        }

        let query = args[1].clone();
        let file_path = args[2].clone();
        // To set the env var in a powershell session: $env:CASE_INSENSITIVE = "true"
        let is_case_sensitive = env::var("CASE_INSENSITIVE").is_err();

        Ok(Config { query, file_path, is_case_sensitive })
    }
}

pub fn run(config: &Config) -> Result<(), Box<dyn Error>> {
    let file_contents = fs::read_to_string(&config.file_path)?;

    println!(
        "Searching for '{}' in file '{}'.",
        &config.query, &config.file_path
    );

    let results = if config.is_case_sensitive {
        search_case_sensitive(&config.query, &file_contents)
    } else {
        search_case_insensitive(&config.query, &file_contents)
    };

    for line in results {
        println!("{line}");
    }

    Ok(())
}

fn search_case_sensitive<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
    let mut result = Vec::new();
    for line in contents.lines() {
        if line.contains(query) {
            result.push(line);
        }
    }
    result
}

fn search_case_insensitive<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
    let query = query.to_lowercase();
    let mut result = Vec::new();
    for line in contents.lines() {
        if line.to_lowercase().contains(&query) {
            result.push(line);
        }
    }
    result
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn canse_sensitive() {
        let query = "duct";
        let contents = "\
Rust:
safe, fast, productive.
Pick three.
Duct tape.";
        assert_eq!(
            vec!["safe, fast, productive."],
            search_case_sensitive(query, contents)
        );
    }

    #[test]
    fn case_insensitive() {
        let query = "rUsT";
        let contents = "\
Rust:
safe, fast, productive.
Pick three.
Trust me.";

        assert_eq!(
            vec!["Rust:", "Trust me."],
            search_case_insensitive(query, contents)
        );
    }
}
