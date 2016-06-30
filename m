Received: from mx1.redhat.com ([209.132.183.28]:48967 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932204AbcF3QVX (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 12:21:23 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06B1931CECB
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 16:21:10 +0000 (UTC)
Date: Fri, 1 Jul 2016 00:21:08 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] xfstests: Fix installation for extended
Message-ID: <20160630162107.GJ23649@eguan.usersys.redhat.com>
References: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
 <1467302784-32755-1-git-send-email-jtulak@redhat.com>
 <CACj3i722hDncFLkN-eZGPPCZ4gSQifwnVX5wpWr_d7dMh5-oOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACj3i722hDncFLkN-eZGPPCZ4gSQifwnVX5wpWr_d7dMh5-oOQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 06:08:09PM +0200, Jan Tulak wrote:
> On Thu, Jun 30, 2016 at 6:06 PM, Jan Tulak <jtulak@redhat.com> wrote:
> > xfstests supports extended test names like 314-foo-bar, but installation of
> > these tests was skipped (not matching a regexp). So this patch fixes the
> > makefiles in tests/xfs/.
> >
> > This change will have to be repeated later for other directories, as adding it
> > now everywhere would cause make install to fail if no such extended name is
> > present in the dir.
> >
> > Signed-off-by: Jan Tulak <jtulak@redhat.com>
> > ---
> > UPDATE:
> > Let it be just in tests/xfs/.
> >
> > NOTE: if tested without at first merging my 400-input-valiation test, make
> > install will fail again. :-)
> >
> > Signed-off-by: Jan Tulak <jtulak@redhat.com>
> > ---
> >  tests/xfs/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tests/xfs/Makefile b/tests/xfs/Makefile
> > index db94be0..e9b98a3 100644
> > --- a/tests/xfs/Makefile
> > +++ b/tests/xfs/Makefile
> > @@ -13,8 +13,10 @@ include $(BUILDRULES)
> >  install:
> >         $(INSTALL) -m 755 -d $(TARGET_DIR)
> >         $(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)
> > +       $(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR)
> >         $(INSTALL) -m 644 group $(TARGET_DIR)
> >         $(INSTALL) -m 644 [0-9]??.* $(TARGET_DIR)
> > +       $(INSTALL) -m 644 [0-9]??-*.* $(TARGET_DIR)
> >
> >  # Nothing.
> >  install-dev install-lib:
> > --
> > 2.5.5
> >
> 
> Ah, I'm sorry, I cut "names" from $SUBJ. Should be "Extended names",
> but I think it is not worth of a fixing patch...

I queued it up with the summary fixed :)

Eryu
