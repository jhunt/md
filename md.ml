let _ = In_channel.input_all In_channel.stdin |> Omd.of_string |> Omd.to_html |> print_endline
