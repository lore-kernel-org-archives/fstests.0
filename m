Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2721CC433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 13:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0184861A07
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 13:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhCXNqS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 09:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235573AbhCXNqB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Mar 2021 09:46:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81772619E8;
        Wed, 24 Mar 2021 13:45:58 +0000 (UTC)
Date:   Wed, 24 Mar 2021 14:45:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 0/6] fstests: add idmapped mounts tests
Message-ID: <20210324134554.rio27zsmsfzs6eqa@wittgenstein>
References: <20210322134522.916512-1-brauner@kernel.org>
 <20210322135002.6tyexslvqfiaari7@wittgenstein>
 <20210322142115.4ehetdcopvmvs7fl@wittgenstein>
 <CAOQ4uxjB3aDehSeomAvi-7rUJRZmmR=GQFAqod9SzSoGu5PjnA@mail.gmail.com>
 <20210324084126.ke7mden2s3a35koa@wittgenstein>
 <CAOQ4uxjwN+3xAjen5G8pRccYX_4bSCrcQUR5pqi2bFRpGPeSqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjwN+3xAjen5G8pRccYX_4bSCrcQUR5pqi2bFRpGPeSqw@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 24, 2021 at 01:24:36PM +0200, Amir Goldstein wrote:
> On Wed, Mar 24, 2021 at 10:41 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Wed, Mar 24, 2021 at 10:03:43AM +0200, Amir Goldstein wrote:
> > > On Mon, Mar 22, 2021 at 4:22 PM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > >
> > > > On Mon, Mar 22, 2021 at 02:50:02PM +0100, Christian Brauner wrote:
> > > > > On Mon, Mar 22, 2021 at 02:45:16PM +0100, Christian Brauner wrote:
> > > > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > >
> > > > > > Hey everyone,
> > > > > >
> > > > > > This series is available from:
> > > > > > https://git.kernel.org/brauner/xfstests-dev/h/idmapped_mounts
> > > > > > https://gitlab.com/brauner/xfstests/-/tree/idmapped_mounts
> > > > > > https://github.com/brauner/xfstests/tree/idmapped_mounts
> > > > >
> > > > > I sent this series from my kernel.org mail address and patch 2/6 hasn't
> > > > > made it through this time too. So it seems that vger is rejecting it due
> > > > > to its size is my guess. I'll go poing the #korg folks to ask what's
> > > > > going on and whether that can be handled.
> > > >
> > > > Ok, Konstantin confirmed that patch 2/6 got dropped because of it's
> > > > size. Nothing to do about this now but just as an fyi.
> > > >
> > >
> > > Since 2/6 got dropped, I'll write a small nit here which is also
> >
> > You could still pull it from above. I don't think resending would retain
> > the patch afaict until vger has been ported by Konstantin.
> >
> > > relevant to the rest of the series:
> > >
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -634,3 +634,4 @@
> > >  629 auto quick rw copy_range
> > >  630 auto quick rw dedupe clone
> > >  631 auto quick mount
> > > +632 auto atime attr cap io_uring mount perms quick rw unlink
> > >
> > > This is a mouthful of test tags, but that doesn't hurt.
> > > I would personally not bother with obscure tags like 'unlink' but whatever.
> > >
> > > Two things I would request are:
> > > 1. Keep 'auto quick' before all other tags. There is no strong rule about
> > >     this format, but that's the common practice and it makes sense IMO
> > >     because -g auto and -g quick are the far more commonly used groups of
> > >     tests, so it's convenient to be able to 'eye grep' those tests in
> > > the group file.
> > > 2. Please tags all the idmapped tests with a tag 'idmapped' (or whatever)
> > >     This would be used for running tests with -g idmapped for quick sanity
> > >     when modifiying idmapped mounts related code
> >
> > Ok, I'll wait for Eryu to respond (Since I assume he'll be the one in
> > charge of applying it?)
> 
> He will.
> 
> Meanwhile, found a bug in Makefile:
> 
> --- a/src/idmapped-mounts/Makefile
> +++ b/src/idmapped-mounts/Makefile
> @@ -25,11 +25,11 @@ depend: .dep
> 
>  include $(BUILDRULES)
> 
> -idmapped-mounts:
> +idmapped-mounts: $(CFILES_IDMAPPED_MOUNTS)
>         @echo "    [CC]    $@"
>         $(Q)$(LTLINK) $(CFILES_IDMAPPED_MOUNTS) -o $@ $(CFLAGS)
> $(LDFLAGS) $(LDLIBS)
> 
> -mount-idmapped:
> +mount-idmapped: $(CFILES_MOUNT_IDMAPPED)
>         @echo "    [CC]    $@"
>         $(Q)$(LTLINK) $(CFILES_MOUNT_IDMAPPED) -o $@ $(CFLAGS)
> $(LDFLAGS) $(LDLIBS)

Stupid question maybe but what is the reason for this change?
It builds fine without those lines. 

Building idmapped-mounts
[CC]    idmapped-mounts
[CC]    mount-idmapped

>  ---
> 
> And in parsing of /proc/<pid>/ns/user:
> 
> --- a/src/idmapped-mounts/mount-idmapped.c
> +++ b/src/idmapped-mounts/mount-idmapped.c
> @@ -175,7 +175,7 @@ static int write_id_mapping(idmap_type_t map_type,
> pid_t pid, const char *buf, s
>         int fd = -EBADF, setgroups_fd = -EBADF;
>         int fret = -1;
>         int ret;
> -       char path[STRLITERALLEN("/proc") + INTTYPE_TO_STRLEN(pid_t) +
> +       char path[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
>                   STRLITERALLEN("/setgroups") + 1];

Thanks. Though it's very unlikely for the kernel to assign a pid that is
at least 100 billion. Even newest systems only bump the maximum pid
number to 4m and we would've thankfully caught this in the snprintf()s
below.

> 
>         if (geteuid() != 0 && map_type == ID_TYPE_GID) {
> @@ -273,7 +273,7 @@ static int get_userns_fd_from_idmap(struct list *idmap)
>  {
>         int ret;
>         pid_t pid;
> -       char path_ns[STRLITERALLEN("/proc") + INTTYPE_TO_STRLEN(pid_t) +
> +       char path_ns[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
>                   STRLITERALLEN("/ns/user") + 1];
> 
>         pid = do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER | CLONE_NEWNS);
> @@ -364,7 +364,7 @@ int main(int argc, char *argv[])
>         while ((ret = getopt_long_only(argc, argv, "", longopts,
> &index)) != -1) {
>                 switch (ret) {
>                 case 'a':
> -                       if (strnequal(optarg, "/proc",
> STRLITERALLEN("/proc/"))) {
> +                       if (strnequal(optarg, "/proc/",
> STRLITERALLEN("/proc/"))) {
>                                 fd_userns = open(optarg, O_RDONLY | O_CLOEXEC);

That's currently not used by the code and would've simply meant we
failed.

Will fix this up and push it to the tree I linked to earlier.
Thank you!
Christian
