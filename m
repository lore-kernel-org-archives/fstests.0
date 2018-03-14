Received: from mail-yw0-f194.google.com ([209.85.161.194]:33213 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeCNKGR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Mar 2018 06:06:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180314090230.25055-1-wqu@suse.com>
References: <20180314090230.25055-1-wqu@suse.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Mar 2018 12:06:15 +0200
Message-ID: <CAOQ4uxgr=zVZ_n5Gs==hWnaa4bSAav60Aa+GKzSdEQC2O+b93g@mail.gmail.com>
Subject: Re: [PATCH 1/3] fstests: log-writes: Add support to output human
 readable flags
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: Linux Btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 14, 2018 at 11:02 AM, Qu Wenruo <wqu@suse.com> wrote:
> Also change the flag numeric output to hex.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  src/log-writes/log-writes.c | 70 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 63 insertions(+), 7 deletions(-)
>
> diff --git a/src/log-writes/log-writes.c b/src/log-writes/log-writes.c
> index 09391574..a872429d 100644
> --- a/src/log-writes/log-writes.c
> +++ b/src/log-writes/log-writes.c
> @@ -120,6 +120,58 @@ int log_discard(struct log *log, struct log_write_entry *entry)
>         return 0;
>  }
>
> +#define DEFINE_LOG_FLAGS_STR_ENTRY(x)  \
> +       {LOG_##x##_FLAG, #x}
> +
> +struct flags_to_str_entry {
> +       u64 flags;
> +       const char *str;
> +} log_flags_table[] = {
> +       DEFINE_LOG_FLAGS_STR_ENTRY(FLUSH),
> +       DEFINE_LOG_FLAGS_STR_ENTRY(FUA),
> +       DEFINE_LOG_FLAGS_STR_ENTRY(DISCARD),
> +       DEFINE_LOG_FLAGS_STR_ENTRY(MARK)
> +};
> +
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +#define LOG_FLAGS_BUF_SIZE     128
> +/*
> + * Convert numeric flags to human readable flags.
> + * @flags:     numeric flags
> + * @buf:       output buffer for human readable string.
> + *             must have enough space (LOG_FLAGS_BUF_SIZE) to contain all
> + *             the string
> + */
> +static void entry_flags_to_str(u64 flags, char *buf)
> +{
> +       int empty = 1;
> +       int left_len;
> +       int i;
> +
> +       buf[0] = '\0';
> +       for (i = 0; i < ARRAY_SIZE(log_flags_table); i++) {
> +               if (flags & log_flags_table[i].flags) {
> +                       if (!empty)
> +                               strncat(buf, "|", LOG_FLAGS_BUF_SIZE);
> +                       empty = 0;
> +                       strncat(buf, log_flags_table[i].str, LOG_FLAGS_BUF_SIZE);
> +                       flags &= ~log_flags_table[i].flags;
> +               }
> +       }
> +       if (flags) {
> +               if (!empty)
> +                       strncat(buf, "|", LOG_FLAGS_BUF_SIZE);
> +               empty = 0;
> +               left_len = LOG_FLAGS_BUF_SIZE - strnlen(buf,
> +                                                       LOG_FLAGS_BUF_SIZE);
> +               if (left_len > 0)
> +                       snprintf(buf + strnlen(buf, LOG_FLAGS_BUF_SIZE),
> +                                left_len, "UNKNOWN.0x%llx", flags);
> +       }
> +       if (empty)
> +               strncpy(buf, "NONE", LOG_FLAGS_BUF_SIZE);
> +}
> +
>  /*
>   * @log: the log we are replaying.
>   * @entry: entry to be replayed.
> @@ -179,6 +231,7 @@ int log_replay_next_entry(struct log *log, struct log_write_entry *entry,
>         size_t read_size = read_data ? log->sectorsize :
>                 sizeof(struct log_write_entry);
>         char *buf;
> +       char flags_buf[LOG_FLAGS_BUF_SIZE];
>         ssize_t ret;
>         off_t offset;
>         int skip = 0;
> @@ -210,19 +263,20 @@ int log_replay_next_entry(struct log *log, struct log_write_entry *entry,
>                 log->cur_pos += read_size;
>         }
>
> +       flags = le64_to_cpu(entry->flags);
> +       entry_flags_to_str(flags, flags_buf);
>         skip = log_should_skip(log, entry);
>         if (log_writes_verbose > 1 || (log_writes_verbose && !skip)) {
> -               printf("%s %d@%llu: sector %llu, size %llu, flags %llu\n",
> +               printf("%s %d@%llu: sector %llu, size %llu, flags 0x%llx(%s)\n",
>                        skip ? "skipping" : "replaying",
>                        (int)log->cur_entry - 1, log->cur_pos / log->sectorsize,
>                        (unsigned long long)le64_to_cpu(entry->sector),
>                        (unsigned long long)size,
> -                      (unsigned long long)le64_to_cpu(entry->flags));
> +                      (unsigned long long)flags, flags_buf);
>         }
>         if (!size)
>                 return 0;
>
> -       flags = le64_to_cpu(entry->flags);
>         if (flags & LOG_DISCARD_FLAG)
>                 return log_discard(log, entry);
>
> @@ -301,7 +355,7 @@ int log_seek_entry(struct log *log, u64 entry_num)
>                         return -1;
>                 }
>                 if (log_writes_verbose > 1)
> -                       printf("seek entry %d@%llu: %llu, size %llu, flags %llu\n",
> +                       printf("seek entry %d@%llu: %llu, size %llu, flags 0x%llx\n",
>                                (int)i, log->cur_pos / log->sectorsize,
>                                (unsigned long long)le64_to_cpu(entry.sector),
>                                (unsigned long long)le64_to_cpu(entry.nr_sectors),
> @@ -339,6 +393,7 @@ int log_seek_next_entry(struct log *log, struct log_write_entry *entry,
>         size_t read_size = read_data ? log->sectorsize :
>                 sizeof(struct log_write_entry);
>         u64 flags;
> +       char flags_buf[LOG_FLAGS_BUF_SIZE];
>         ssize_t ret;
>
>         if (log->cur_entry >= log->nr_entries)
> @@ -366,14 +421,15 @@ int log_seek_next_entry(struct log *log, struct log_write_entry *entry,
>         } else {
>                 log->cur_pos += read_size;
>         }
> +       flags = le64_to_cpu(entry->flags);
> +       entry_flags_to_str(flags, flags_buf);
>         if (log_writes_verbose > 1)
> -               printf("seek entry %d@%llu: %llu, size %llu, flags %llu\n",
> +               printf("seek entry %d@%llu: %llu, size %llu, flags 0x%llx(%s)\n",
>                        (int)log->cur_entry - 1, log->cur_pos / log->sectorsize,
>                        (unsigned long long)le64_to_cpu(entry->sector),
>                        (unsigned long long)le64_to_cpu(entry->nr_sectors),
> -                      (unsigned long long)le64_to_cpu(entry->flags));
> +                      (unsigned long long)flags, flags_buf);
>
> -       flags = le64_to_cpu(entry->flags);
>         read_size = le64_to_cpu(entry->nr_sectors) * log->sectorsize;
>         if (!read_size || (flags & LOG_DISCARD_FLAG))
>                 return 0;
> --
> 2.15.1
>
