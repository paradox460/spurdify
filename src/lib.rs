use aho_corasick::{AhoCorasickBuilder, MatchKind};
use lazy_static::lazy_static;
use rand::seq::SliceRandom;
use rand::{thread_rng, Rng};
use regex::{Captures, Regex};

include!(concat!(env!("OUT_DIR"), "/replacements.in"));

fn big_emote(input: &str) -> String {
  let leader: String;
  let mut mouth = "D".to_string();

  match input {
    "." => {
      leader = ":".to_string();
    }
    "," => {
      leader = "x".to_string();
    }
    ";" => {
      leader = ":".to_string();
      mouth = "O".to_string();
    }
    _ => {
      return input.to_string();
    }
  }

  let emoji_length = thread_rng().gen_range(1..=5);

  return format!(" {}{}", leader, mouth.repeat(emoji_length));
}

fn silly_o() -> String {
  const SILLY_OS: [&str; 3] = ["ö", "ø", "0"];
  return SILLY_OS.choose(&mut thread_rng()).unwrap().to_string();
}

pub fn spurdify(mut input: String) -> String {
  lazy_static! {
    static ref MINOR_REPLACEMENT: Regex = Regex::new(r"[.,;o]").unwrap();
  }
  input = input.to_lowercase();
  let ac = AhoCorasickBuilder::new()
    .match_kind(MatchKind::LeftmostFirst)
    .build(RULES);
  input = ac.replace_all(&input, &REPLACEMENTS);

  return MINOR_REPLACEMENT
    .replace_all(&input, |caps: &Captures| match &caps[0] {
      "o" => silly_o(),
      "." | "," | ";" => big_emote(&caps[0]).to_string(),
      _ => "".to_string(),
    })
    .to_string();
}
