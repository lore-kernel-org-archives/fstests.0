Received: from mail-yb1-f195.google.com ([209.85.219.195]:36794 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDFQtT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 6 Apr 2019 12:49:19 -0400
MIME-Version: 1.0
References: <20190328053507.10191-1-wqu@suse.com>
In-Reply-To: <20190328053507.10191-1-wqu@suse.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 6 Apr 2019 19:49:06 +0300
Message-ID: <CAOQ4uxhNe689bzcpTi5LUEiDN4X0JkKSWPtr+1bhYYQCWnowEA@mail.gmail.com>
Subject: Re: [PATCH] fstests: log-writes: Add new option to replay/find next
 write to sector
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: Linux Btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 28, 2019 at 7:36 AM Qu Wenruo <wqu@suse.com> wrote:
>
> For kernel operation we have METADATA/FUA/FLUSH flags as a beacon, but
> for user space write we don't have any useful flag unless the user space
> tool call fsync() to generate a FLUSH bio.
>
> This means for user space write, we don't really have an equivalent of
> --next-fua to find super block write.
>
> So this patch will add a new option, --next-write <sector> to
> replay/find next write to certain sector.
> And normally the <sector> should be super block sector number.
>
> With that, we can replay to super block write even it's user space
> triggering the write.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This is useful, but it could be simpler and even more useful.
See suggestion below.

> ---
>  src/log-writes/replay-log.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/src/log-writes/replay-log.c b/src/log-writes/replay-log.c
> index c16df40e5741..0d0ec49c8a00 100644
> --- a/src/log-writes/replay-log.c
> +++ b/src/log-writes/replay-log.c
> @@ -9,6 +9,7 @@
>  enum option_indexes {
>         NEXT_FLUSH,
>         NEXT_FUA,
> +       NEXT_WRITE,
>         START_ENTRY,
>         END_MARK,
>         LOG,
> @@ -28,6 +29,7 @@ enum option_indexes {
>  static struct option long_options[] = {
>         {"next-flush", no_argument, NULL, 0},
>         {"next-fua", no_argument, NULL, 0},
> +       {"next-write", required_argument, NULL, 0},

Suggest no_argument like next-fua,next-flush and assign
a special flag or something to find WRITE entries
because start/end-sector already gives to the ability
to filter by single sector or range of sectors.
If fact I added these option to debug the exact case you are
describing.

>         {"start-entry", required_argument, NULL, 0},
>         {"end-mark", required_argument, NULL, 0},
>         {"log", required_argument, NULL, 0},
> @@ -53,6 +55,8 @@ static void usage(void)
>         fprintf(stderr, "\t--limit <number> - number of entries to replay\n");
>         fprintf(stderr, "\t--next-flush - replay to/find the next flush\n");
>         fprintf(stderr, "\t--next-fua - replay to/find the next fua\n");
> +       fprintf(stderr, "\t--next-write <sector> - replay to/find the next "
> +                       "write to <sector>\n");
>         fprintf(stderr, "\t--start-entry <entry> - start at the given "
>                 "entry #\n");
>         fprintf(stderr, "\t--start-mark <mark> - mark to start from\n");
> @@ -139,6 +143,7 @@ int main(int argc, char **argv)
>         char *logfile = NULL, *replayfile = NULL, *fsck_command = NULL;
>         struct log_write_entry *entry;
>         u64 stop_flags = 0;
> +       u64 stop_sector = 0;
>         u64 start_entry = 0;
>         u64 start_sector = 0;
>         u64 end_sector = -1ULL;
> @@ -173,6 +178,14 @@ int main(int argc, char **argv)
>                 case NEXT_FUA:
>                         stop_flags |= LOG_FUA_FLAG;
>                         break;
> +               case NEXT_WRITE:
> +                       stop_sector = strtoull(optarg, &tmp, 0);
> +                       if (tmp && *tmp != '\0') {
> +                               fprintf(stderr, "Invalid sector number\n");
> +                               exit(1);
> +                       }
> +                       tmp = NULL;
> +                       break;
>                 case START_ENTRY:
>                         start_entry = strtoull(optarg, &tmp, 0);
>                         if (tmp && *tmp != '\0') {
> @@ -324,7 +337,8 @@ int main(int argc, char **argv)
>                 while ((ret = log_seek_next_entry(log, entry, 1)) == 0) {
>                         num_entries++;
>                         if ((run_limit && num_entries == run_limit) ||
> -                           should_stop(entry, stop_flags, end_mark)) {
> +                           should_stop(entry, stop_flags, end_mark) ||
> +                           (stop_sector && entry->sector == stop_sector)) {

You seem to have only implemented "find" mode and not "replay" mode
(the log_replay_next_entry() loop).
I suggest that you work log_should_skip() into both "find" and "replay"
loops. i.e. (!log_should_skip() && should_stop()).

Thanks,
Amir.
