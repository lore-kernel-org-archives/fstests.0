Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01236C433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B9861A0B
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 11:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhCXLZC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 07:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbhCXLYs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Mar 2021 07:24:48 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CFCC061763
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 04:24:48 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y17so9378786ila.6
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 04:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQHi/fdhKfbXq7RZ9dlotKK0qV1xLdowqt4c6TLvC4M=;
        b=pz68fhAajYhcrNLW9SGf0610MsQvzldh8QX7EbesUw0vD9FUewoWq+rDfDPdVFJptI
         MSCXE++sTQyn+B9LLw3j2Ehaw5cbwoBZ50V3VZnp6PNJmOfUz534QlUPRCRJNYdXGYZK
         30C/nW7vCdUBFVyX0Xa2fnJ6W80/GjUcztxnuMFB1vT94p903QXYZ54l/JqLvFDjrg+i
         5GLiYF0f47mpBetGocc8SbHNAj3oZo+WROCWQ8/7P1d2oPL2KIpCgtOVTktkG0+zjAui
         ozcOM8OQlHDLfS4roerOjoGGlRhSheopd7wWDSlLUs/wAYxmrynsA/hxrbIuPekT/2Tr
         Mvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQHi/fdhKfbXq7RZ9dlotKK0qV1xLdowqt4c6TLvC4M=;
        b=Sb0l/CXxQu8Aihg8trLOrWi0vEvyHmoeCbY96cAef5gNcLqc7EwHgyKKIagZUATtsy
         zcJVnMqvQm7ijIIgDH2yO42k+2naXYPGIRZj+XZ4okxwMsm5zzXR7jPmcTZ0lMynrKtO
         JsRIv5pN2IDedenlp51kA8C+zGWjh7MMpspBn7i9Bq5+P39xdVpFWB+XqPBXkK1qfsaQ
         J/8mudO8VEz7LTtzTWvFMmv3RX1YOqO1cXUSXU3/uwbGnsw+oqSAatnGmtHRdAPym5RQ
         uV6Qm4h/oXOde1uNHeI1ZWctaPbJrmT8lgtZEUtFT5NYwtJvfTsr5AW4fQrJrAvMYnAR
         HZIQ==
X-Gm-Message-State: AOAM532dpzvAYLg0QjZNgc8VVOmlmyCjh1ReYe7wXwT0UNS0N1gneK8x
        y8oNSbK2OTosQerUhUp/9r67x6SAlxA3TOCgjIvZPkqnc5I=
X-Google-Smtp-Source: ABdhPJyYv31NTmwTRsE/F4Xp2igXtTfAd7mP+EV+LSkdCfBUeQKIiDl/7820Fa5j1JMUMA8oGcj+2YJsfM0QyKJZBSQ=
X-Received: by 2002:a92:50b:: with SMTP id q11mr2306313ile.250.1616585087668;
 Wed, 24 Mar 2021 04:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210322134522.916512-1-brauner@kernel.org> <20210322135002.6tyexslvqfiaari7@wittgenstein>
 <20210322142115.4ehetdcopvmvs7fl@wittgenstein> <CAOQ4uxjB3aDehSeomAvi-7rUJRZmmR=GQFAqod9SzSoGu5PjnA@mail.gmail.com>
 <20210324084126.ke7mden2s3a35koa@wittgenstein>
In-Reply-To: <20210324084126.ke7mden2s3a35koa@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 13:24:36 +0200
Message-ID: <CAOQ4uxjwN+3xAjen5G8pRccYX_4bSCrcQUR5pqi2bFRpGPeSqw@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] fstests: add idmapped mounts tests
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <brauner@kernel.org>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 24, 2021 at 10:41 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Mar 24, 2021 at 10:03:43AM +0200, Amir Goldstein wrote:
> > On Mon, Mar 22, 2021 at 4:22 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > On Mon, Mar 22, 2021 at 02:50:02PM +0100, Christian Brauner wrote:
> > > > On Mon, Mar 22, 2021 at 02:45:16PM +0100, Christian Brauner wrote:
> > > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > >
> > > > > Hey everyone,
> > > > >
> > > > > This series is available from:
> > > > > https://git.kernel.org/brauner/xfstests-dev/h/idmapped_mounts
> > > > > https://gitlab.com/brauner/xfstests/-/tree/idmapped_mounts
> > > > > https://github.com/brauner/xfstests/tree/idmapped_mounts
> > > >
> > > > I sent this series from my kernel.org mail address and patch 2/6 hasn't
> > > > made it through this time too. So it seems that vger is rejecting it due
> > > > to its size is my guess. I'll go poing the #korg folks to ask what's
> > > > going on and whether that can be handled.
> > >
> > > Ok, Konstantin confirmed that patch 2/6 got dropped because of it's
> > > size. Nothing to do about this now but just as an fyi.
> > >
> >
> > Since 2/6 got dropped, I'll write a small nit here which is also
>
> You could still pull it from above. I don't think resending would retain
> the patch afaict until vger has been ported by Konstantin.
>
> > relevant to the rest of the series:
> >
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -634,3 +634,4 @@
> >  629 auto quick rw copy_range
> >  630 auto quick rw dedupe clone
> >  631 auto quick mount
> > +632 auto atime attr cap io_uring mount perms quick rw unlink
> >
> > This is a mouthful of test tags, but that doesn't hurt.
> > I would personally not bother with obscure tags like 'unlink' but whatever.
> >
> > Two things I would request are:
> > 1. Keep 'auto quick' before all other tags. There is no strong rule about
> >     this format, but that's the common practice and it makes sense IMO
> >     because -g auto and -g quick are the far more commonly used groups of
> >     tests, so it's convenient to be able to 'eye grep' those tests in
> > the group file.
> > 2. Please tags all the idmapped tests with a tag 'idmapped' (or whatever)
> >     This would be used for running tests with -g idmapped for quick sanity
> >     when modifiying idmapped mounts related code
>
> Ok, I'll wait for Eryu to respond (Since I assume he'll be the one in
> charge of applying it?)

He will.

Meanwhile, found a bug in Makefile:

--- a/src/idmapped-mounts/Makefile
+++ b/src/idmapped-mounts/Makefile
@@ -25,11 +25,11 @@ depend: .dep

 include $(BUILDRULES)

-idmapped-mounts:
+idmapped-mounts: $(CFILES_IDMAPPED_MOUNTS)
        @echo "    [CC]    $@"
        $(Q)$(LTLINK) $(CFILES_IDMAPPED_MOUNTS) -o $@ $(CFLAGS)
$(LDFLAGS) $(LDLIBS)

-mount-idmapped:
+mount-idmapped: $(CFILES_MOUNT_IDMAPPED)
        @echo "    [CC]    $@"
        $(Q)$(LTLINK) $(CFILES_MOUNT_IDMAPPED) -o $@ $(CFLAGS)
$(LDFLAGS) $(LDLIBS)
 ---

And in parsing of /proc/<pid>/ns/user:

--- a/src/idmapped-mounts/mount-idmapped.c
+++ b/src/idmapped-mounts/mount-idmapped.c
@@ -175,7 +175,7 @@ static int write_id_mapping(idmap_type_t map_type,
pid_t pid, const char *buf, s
        int fd = -EBADF, setgroups_fd = -EBADF;
        int fret = -1;
        int ret;
-       char path[STRLITERALLEN("/proc") + INTTYPE_TO_STRLEN(pid_t) +
+       char path[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
                  STRLITERALLEN("/setgroups") + 1];

        if (geteuid() != 0 && map_type == ID_TYPE_GID) {
@@ -273,7 +273,7 @@ static int get_userns_fd_from_idmap(struct list *idmap)
 {
        int ret;
        pid_t pid;
-       char path_ns[STRLITERALLEN("/proc") + INTTYPE_TO_STRLEN(pid_t) +
+       char path_ns[STRLITERALLEN("/proc/") + INTTYPE_TO_STRLEN(pid_t) +
                  STRLITERALLEN("/ns/user") + 1];

        pid = do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER | CLONE_NEWNS);
@@ -364,7 +364,7 @@ int main(int argc, char *argv[])
        while ((ret = getopt_long_only(argc, argv, "", longopts,
&index)) != -1) {
                switch (ret) {
                case 'a':
-                       if (strnequal(optarg, "/proc",
STRLITERALLEN("/proc/"))) {
+                       if (strnequal(optarg, "/proc/",
STRLITERALLEN("/proc/"))) {
                                fd_userns = open(optarg, O_RDONLY | O_CLOEXEC);
---

Thanks,
Amir.
