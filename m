Received: from mail-io0-f176.google.com ([209.85.223.176]:35137 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbcF3QPq (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2016 12:15:46 -0400
Received: by mail-io0-f176.google.com with SMTP id f30so76245713ioj.2
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 09:15:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1467302784-32755-1-git-send-email-jtulak@redhat.com>
References: <1467212275-14344-1-git-send-email-jtulak@redhat.com> <1467302784-32755-1-git-send-email-jtulak@redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Thu, 30 Jun 2016 18:08:09 +0200
Message-ID: <CACj3i722hDncFLkN-eZGPPCZ4gSQifwnVX5wpWr_d7dMh5-oOQ@mail.gmail.com>
Subject: Re: [PATCH v3] xfstests: Fix installation for extended
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>, Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 6:06 PM, Jan Tulak <jtulak@redhat.com> wrote:
> xfstests supports extended test names like 314-foo-bar, but installation of
> these tests was skipped (not matching a regexp). So this patch fixes the
> makefiles in tests/xfs/.
>
> This change will have to be repeated later for other directories, as adding it
> now everywhere would cause make install to fail if no such extended name is
> present in the dir.
>
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
> UPDATE:
> Let it be just in tests/xfs/.
>
> NOTE: if tested without at first merging my 400-input-valiation test, make
> install will fail again. :-)
>
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
>  tests/xfs/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/xfs/Makefile b/tests/xfs/Makefile
> index db94be0..e9b98a3 100644
> --- a/tests/xfs/Makefile
> +++ b/tests/xfs/Makefile
> @@ -13,8 +13,10 @@ include $(BUILDRULES)
>  install:
>         $(INSTALL) -m 755 -d $(TARGET_DIR)
>         $(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
> +       $(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR)
>         $(INSTALL) -m 644 group $(TARGET_DIR)
>         $(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
> +       $(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR)
>
>  # Nothing.
>  install-dev install-lib:
> --
> 2.5.5
>

Ah, I'm sorry, I cut "names" from $SUBJ. Should be "Extended names",
but I think it is not worth of a fixing patch...

Thanks,
Jan

-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
