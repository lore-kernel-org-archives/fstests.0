Return-Path: <SRS0=F1dN=6P=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6B9C47254
	for <linux-fstests@archiver.kernel.org>; Fri,  1 May 2020 04:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143662071C
	for <linux-fstests@archiver.kernel.org>; Fri,  1 May 2020 04:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTWm/eze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgEAEaT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 May 2020 00:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726153AbgEAEaT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 1 May 2020 00:30:19 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464B4C035494
        for <fstests@vger.kernel.org>; Thu, 30 Apr 2020 21:30:19 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i3so3868636ioo.13
        for <fstests@vger.kernel.org>; Thu, 30 Apr 2020 21:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foeLYCOd7n//VN5BuFhTbWwyuIDJ5h4WtOlQIO2b+EM=;
        b=LTWm/ezeWihQnW6ex/lOzDFxZ/4DSgIvKz5vvCi17JcTD4w/wkxte6PMQn0JiUeFz0
         ESlEIKabo6j4gbaKiBNQz66dnjkW6nry5M8Ggv63jk8hpjogTotPJYMe8Ongt94BQGPf
         EWhE8X/KkOXDI5s/0lZRWISES8G1I+TmgdcWlY8dpeYHyE3q7meEZILseu/ox3UXcUSl
         NG7i3OdOsdqeEf9JIfTStFn0AFOjyQv6ym94wu2m3xPuMRsaBpSEQkleUPW7wSeOcH35
         F/b2Ftygvo1XU7jdmMRDHJZ4yWsF0PG971x+G8Ke31MqloRaCJTPYHd33MiFAQRds/8P
         ZASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foeLYCOd7n//VN5BuFhTbWwyuIDJ5h4WtOlQIO2b+EM=;
        b=DcAVAQrkYhiH9P1tI8T/QtkxBGUuF5CeUSbv5ZdyHkLg2ito/DoU+Kk3KDhgcQhU/l
         PpmOMzfJyukwDIGHPke0FlmlCNPLtaIFRi92WDcW5SeURk7vTbnxlgH//3V/2ZTvwdNs
         9Sc3QeDRBq7HjlvIf7TgiRY8pcOK4sLi4SFHwdNX5zogx4kmKpSgyUWPzFrGKuTRPCrQ
         5qLPIYOwQv1RENO5adGs570JvWnBzmMxwZ4WuATFm/9dxLEu9wRkRwWsjoMczmk92Z6H
         V8XVuRnQuxfvUt8fTtF6DYzPhWi0B1wKPhAc3YruV+8IpPIR80NxlY2zU+0br6sjXp7d
         DoHQ==
X-Gm-Message-State: AGi0PuZF+99K2w4gcKJgE3cxWx5Tn033mTnyEr76ABwQxc4QJ2riBelR
        S6LKnljEdKlZH3QWFusx56fSfa2cyeWA2zXFkQA=
X-Google-Smtp-Source: APiQypKs3u5lqyBo8eeLBrQt+5kQOfBKnHZuG2+MlKmhbY+06a77r8sIyCIu1UeLFq2Cn7dDO3+XxK99fLxPDTK4spA=
X-Received: by 2002:a5e:a90a:: with SMTP id c10mr2220087iod.64.1588307418315;
 Thu, 30 Apr 2020 21:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200430035543.7178-1-raghavan.arvind@gmail.com>
In-Reply-To: <20200430035543.7178-1-raghavan.arvind@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 1 May 2020 07:30:07 +0300
Message-ID: <CAOQ4uxj9t8ijP6Chu4cm0DR+roF5B1fC0gDGTv6ObDxvT=U=Ww@mail.gmail.com>
Subject: Re: [PATCH] fstests: Adds non-recursive and single file mode to fssum
To:     Arvind Raghavan <raghavan.arvind@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Arvind,

This looks great, but I have some suggestion to improve.
One thing is that should be a patch series with a cover letter
and not a single patch, because this way it is much harder to review
and bisect problems later on.

On Thu, Apr 30, 2020 at 8:34 PM Arvind Raghavan
<raghavan.arvind@gmail.com> wrote:
>
> Requires patch: Fix duplicate CLI arguments in fssum

This lines is irrelevant in git history so should be in notes after --- line

>
> Adds flag '-R' for non-recursive mode. Useful for checking a directory
> after an fsync, as POSIX standards only guarantee that the immediate
> files in the directory are synced.
>

Full stop. that should be a patch on its own.

> Added support for files as input, instead of just directories. fssum
> computes the checksum of the single file.
>

That one as well.

> Added a flag for including file size in metadata. Previously it was
> always included. It is useful to ignore file sizes when testing an
> fsync of a directory, as the data of its children is not guaranteed to
> be persisted.

And that one.

>
> Signed-off-by: Arvind Raghavan <raghavan.arvind@gmail.com>
> Signed-off-by: Jayashree Mohan <jaya@cs.utexas.edu>
> Signed-off-by: Vijay Chidambaram <vijay@cs.utexas.edu>
> ---
>  src/fssum.c | 162 +++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 122 insertions(+), 40 deletions(-)
>
> diff --git a/src/fssum.c b/src/fssum.c
> index 3d97a70b..9b32e8cb 100644
> --- a/src/fssum.c
> +++ b/src/fssum.c
> @@ -29,6 +29,7 @@
>  #include <inttypes.h>
>  #include <assert.h>
>  #include <endian.h>
> +#include <libgen.h>
>
>  #define CS_SIZE 16
>  #define CHUNKS 128
> @@ -56,6 +57,7 @@ typedef int (*sum_file_data_t)(int fd, sum_t *dst);
>
>  int gen_manifest = 0;
>  int in_manifest = 0;
> +int recursive = 1;
>  char *checksum = NULL;
>  struct excludes *excludes;
>  int n_excludes = 0;
> @@ -74,13 +76,14 @@ enum _flags {
>         FLAG_XATTRS,
>         FLAG_OPEN_ERROR,
>         FLAG_STRUCTURE,
> +       FLAG_SIZE,
>         NUM_FLAGS
>  };
>
> -const char flchar[] = "ugoamcdtes";
> +const char flchar[] = "ugoamcdtesz";
>  char line[65536];
>
> -int flags[NUM_FLAGS] = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0};
> +int flags[NUM_FLAGS] = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1};
>
>  char *
>  getln(char *buf, int size, FILE *fp)
> @@ -146,12 +149,14 @@ usage(void)
>         fprintf(stderr, "         t       : include xattrs\n");
>         fprintf(stderr, "         e       : include open errors (aborts otherwise)\n");
>         fprintf(stderr, "         s       : include block structure (holes)\n");
> +       fprintf(stderr, "         z       : include file size\n");
>         fprintf(stderr, "    -[UGOAMCDTES]: exclude respective field from calculation\n");

missing Z

>         fprintf(stderr, "    -n           : reset all flags\n");
>         fprintf(stderr, "    -N           : set all flags\n");
>         fprintf(stderr, "    -x path      : exclude path when building checksum (multiple ok)\n");
> +       fprintf(stderr, "    -R           : traverse dirs non-recursively (recursive is default)\n");
>         fprintf(stderr, "    -h           : this help\n\n");
> -       fprintf(stderr, "The default field mask is ugoamCdtES. If the checksum/manifest is read from a\n");
> +       fprintf(stderr, "The default field mask is ugoamCdtESz. If the checksum/manifest is read from a\n");
>         fprintf(stderr, "file, the mask is taken from there and the values given on the command line\n");
>         fprintf(stderr, "are ignored.\n");
>         exit(-1);
> @@ -502,6 +507,92 @@ malformed:
>                 excess_file(fn);
>  }
>
> +void
> +sum_meta(sum_t *meta, struct stat64 *st) {
> +       if (!S_ISDIR(st->st_mode))
> +               sum_add_u64(meta, st->st_nlink);
> +       if (flags[FLAG_UID])
> +               sum_add_u64(meta, st->st_uid);
> +       if (flags[FLAG_GID])
> +               sum_add_u64(meta, st->st_gid);
> +       if (flags[FLAG_MODE])
> +               sum_add_u64(meta, st->st_mode);
> +       if (flags[FLAG_ATIME])
> +               sum_add_time(meta, st->st_atime);
> +       if (flags[FLAG_MTIME])
> +               sum_add_time(meta, st->st_mtime);
> +       if (flags[FLAG_CTIME])
> +               sum_add_time(meta, st->st_ctime);
> +}
> +void
> +print_manifest(char* path, sum_t *meta, sum_t *cs, struct stat64 *st) {
> +       if (gen_manifest || in_manifest) {
> +               char *fn;
> +               char *m;
> +               char *c;
> +
> +               if (S_ISDIR(st->st_mode))
> +                       strcat(path, "/");
> +               fn = escape(path);
> +               m = sum_to_string(meta);
> +               c = sum_to_string(cs);
> +
> +               if (gen_manifest)
> +                       fprintf(out_fp, "%s %s %s\n", fn, m, c);
> +               if (in_manifest)
> +                       check_manifest(fn, m, c, 0);
> +               free(c);
> +               free(m);
> +               free(fn);
> +       }
> +}
> +

Those helpers are great, but re-factoring should be a separate prep
patch. It is easy to review non-logic-changing-re-factoring and it is hard
to review logic changing and re-factoring together - to human ;-).

> +void
> +sum_file(int fd, sum_t *finalcs, struct stat64 *st, char *path) {
> +       int ret;
> +       sum_file_data_t sum_file_data = flags[FLAG_STRUCTURE] ?
> +                       sum_file_data_strict : sum_file_data_permissive;
> +
> +       sum_t cs;
> +       sum_t meta;
> +
> +       sum_init(&cs);
> +       sum_init(&meta);
> +
> +       char* name = basename(path);
> +       sum_add(&meta, name, strlen(name));
> +       sum_meta(&meta, st);
> +
> +       if (flags[FLAG_XATTRS]) {
> +               ret = sum_xattrs(fd, &meta);
> +               if (ret < 0) {
> +                       fprintf(stderr, "failed to read xattrs from "
> +                                       "%s: %s\n", path, strerror(-ret));
> +                       exit(-1);
> +               }
> +       }
> +
> +       if (flags[FLAG_SIZE])
> +               sum_add_u64(&meta, st->st_size);
> +
> +       if (flags[FLAG_DATA]) {
> +               ret = sum_file_data(fd, &cs);
> +               if (ret < 0) {
> +                       fprintf(stderr, "read failed for %s: %s\n", path,
> +                                       strerror(errno));
> +                       exit(-1);
> +               }
> +       }
> +
> +       sum_fini(&cs);
> +       sum_fini(&meta);
> +
> +       print_manifest(path, &meta, &cs, st);
> +
> +       sum_add_sum(finalcs, &cs);
> +       sum_add_sum(finalcs, &meta);
> +}
> +
>  void
>  sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>  {
> @@ -582,20 +673,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>
>                 sum_add_u64(&meta, level);
>                 sum_add(&meta, namelist[i], strlen(namelist[i]));
> -               if (!S_ISDIR(st.st_mode))
> -                       sum_add_u64(&meta, st.st_nlink);
> -               if (flags[FLAG_UID])
> -                       sum_add_u64(&meta, st.st_uid);
> -               if (flags[FLAG_GID])
> -                       sum_add_u64(&meta, st.st_gid);
> -               if (flags[FLAG_MODE])
> -                       sum_add_u64(&meta, st.st_mode);
> -               if (flags[FLAG_ATIME])
> -                       sum_add_time(&meta, st.st_atime);
> -               if (flags[FLAG_MTIME])
> -                       sum_add_time(&meta, st.st_mtime);
> -               if (flags[FLAG_CTIME])
> -                       sum_add_time(&meta, st.st_ctime);
> +               sum_meta(&meta, &st);
>                 if (flags[FLAG_XATTRS] &&
>                     (S_ISDIR(st.st_mode) || S_ISREG(st.st_mode))) {
>                         fd = openat(dirfd, namelist[i], 0);
> @@ -618,7 +696,7 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>                                 }
>                         }
>                 }
> -               if (S_ISDIR(st.st_mode)) {
> +               if (S_ISDIR(st.st_mode) && recursive) {
>                         fd = openat(dirfd, namelist[i], 0);
>                         if (fd == -1 && flags[FLAG_OPEN_ERROR]) {
>                                 sum_add_u64(&meta, errno);
> @@ -631,7 +709,8 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>                                 close(fd);
>                         }
>                 } else if (S_ISREG(st.st_mode)) {
> -                       sum_add_u64(&meta, st.st_size);
> +                       if (flags[FLAG_SIZE])
> +                               sum_add_u64(&meta, st.st_size);
>                         if (flags[FLAG_DATA]) {
>                                 if (verbose)
>                                         fprintf(stderr, "file %s\n",
> @@ -672,25 +751,9 @@ sum(int dirfd, int level, sum_t *dircs, char *path_prefix, char *path_in)
>                 }
>                 sum_fini(&cs);
>                 sum_fini(&meta);
> -               if (gen_manifest || in_manifest) {
> -                       char *fn;
> -                       char *m;
> -                       char *c;
> -
> -                       if (S_ISDIR(st.st_mode))
> -                               strcat(path, "/");
> -                       fn = escape(path);
> -                       m = sum_to_string(&meta);
> -                       c = sum_to_string(&cs);
> -
> -                       if (gen_manifest)
> -                               fprintf(out_fp, "%s %s %s\n", fn, m, c);
> -                       if (in_manifest)
> -                               check_manifest(fn, m, c, 0);
> -                       free(c);
> -                       free(m);
> -                       free(fn);
> -               }
> +
> +               print_manifest(path, &meta, &cs, &st);
> +
>                 sum_add_sum(dircs, &cs);
>                 sum_add_sum(dircs, &meta);
>  next:
> @@ -712,7 +775,7 @@ main(int argc, char *argv[])
>         int plen;
>         int elen;
>         int n_flags = 0;
> -       const char *allopts = "heEfuUgGoOaAmMcCdDtTsSnNw:r:vx:";
> +       const char *allopts = "heEfuUgGoOaAmMcCdDtTsSzZnNRw:r:vx:";
>
>         out_fp = stdout;
>         while ((c = getopt(argc, argv, allopts)) != EOF) {
> @@ -720,6 +783,9 @@ main(int argc, char *argv[])
>                 case 'f':
>                         gen_manifest = 1;
>                         break;
> +               case 'R':
> +                       recursive = 0;
> +                       break;
>                 case 'u':
>                 case 'U':
>                 case 'g':
> @@ -740,6 +806,8 @@ main(int argc, char *argv[])
>                 case 'E':
>                 case 's':
>                 case 'S':
> +               case 'z':
> +               case 'Z':
>                         ++n_flags;
>                         parse_flag(c);
>                         break;
> @@ -855,8 +923,22 @@ main(int argc, char *argv[])
>         if (gen_manifest)
>                 fprintf(out_fp, "Flags: %s\n", flagstring);
>
> +       struct stat64 path_st;
> +       if (fstat64(fd, &path_st)) {
> +               perror("fstat");
> +               exit(-1);
> +       }
> +
>         sum_init(&cs);
> -       sum(fd, 1, &cs, path, "");
> +       if (S_ISDIR(path_st.st_mode)) {
> +               sum(fd, 1, &cs, path, "");
> +       } else if (S_ISREG(path_st.st_mode)) {
> +               sum_file(fd, &cs, &path_st, path);
> +       } else {
> +               fprintf(stderr, "path must be file or dir: %s", path);
> +               exit(-1);
> +       }
> +

I would try something different - only after you try to write it we will
know if i was a good idea or not...
factor out sum_one() from the dir entries iteration in the re-factoring patch
then call sum_one() from main() for non-dir in the patch to support single
file sum. And there is not really a need to limit single file sum to
regular file.

It is tempting to just call sum_one() to let it handle file or dir for
either root or node dir, but that change may affect all existing test
and will be harder to verify. So I would rather that sum_one()
will be a stupified factor out of some code chunk to a helper.

Hope this is clear enough - if not, let me know.
Thanks,
Amir.
