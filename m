Received: from mx1.redhat.com ([209.132.183.28]:51756 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbcF3PqE (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 11:46:04 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5274080086
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 15:35:48 +0000 (UTC)
Date: Thu, 30 Jun 2016 23:35:46 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfstests: Fix installation for extended names
Message-ID: <20160630153546.GI23649@eguan.usersys.redhat.com>
References: <1467212275-14344-1-git-send-email-jtulak@redhat.com>
 <1467275710-403-1-git-send-email-jtulak@redhat.com>
 <20160630133346.GE23649@eguan.usersys.redhat.com>
 <CACj3i70ZOVyMiw9z0RJSDAgpWHgLGFSbBFD=xL9OZrV6XAca9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACj3i70ZOVyMiw9z0RJSDAgpWHgLGFSbBFD=xL9OZrV6XAca9w@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 05:19:53PM +0200, Jan Tulak wrote:
> On Thu, Jun 30, 2016 at 3:33 PM, Eryu Guan <eguan@redhat.com> wrote:
> > On Thu, Jun 30, 2016 at 10:35:10AM +0200, Jan Tulak wrote:
> >> xfstests supports extended test names like 314-foo-bar, but installation of
> >> these tests was skipped (not matching a regexp). So this patch fixes the
> >> makefiles in tests directories.
> >>
> >> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> >> ---
> >> UPDATE:
> >>   * install failed when no extended name was present, so suppress errors for
> >>     extended names
> >
> > Hmm, this looks ugly to me :) I was thinking about it too, but didn't
> > work out a better idea. Now I tend to add this installation support to
> > tests/xfs/Makefile only, and we can add the support to other tests when
> > needed. What do you think?
> >
> 
> Yeah. I thought about better regexp, but unfortunately, whatever sh
> Make uses, it has just limited support for that, unlike bash. So, yes,
> add it for xfs tests only... Should I send another patch for that?

Yes, please. Thanks!

Eryu
