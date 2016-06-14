Received: from mx1.redhat.com ([209.132.183.28]:40373 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbcFNLy6 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 14 Jun 2016 07:54:58 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 500553B709
	for <fstests@vger.kernel.org>; Tue, 14 Jun 2016 11:54:58 +0000 (UTC)
Date: Tue, 14 Jun 2016 19:54:56 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/3] generic: test error handling on filesystem shutdown
Message-ID: <20160614115456.GS5140@eguan.usersys.redhat.com>
References: <1465890821-4388-1-git-send-email-eguan@redhat.com>
 <1465890821-4388-2-git-send-email-eguan@redhat.com>
 <20160614114326.GB32443@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160614114326.GB32443@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 14, 2016 at 07:43:26AM -0400, Brian Foster wrote:
> On Tue, Jun 14, 2016 at 03:53:40PM +0800, Eryu Guan wrote:
> > Test XFS EFI/EFD error handling. Though it's an XFS bug, it can ran on
> > any filesystem supports shutdown.
> > 
> > This kernel commit fixed a hang on umount in XFS
> > 8d99fe9 xfs: fix efi/efd error handling to avoid fs shutdown hangs
> > 
> > Though this bug is hard to hit, it's still good to have some coverage.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> 
> The test looks fine, though I wonder if we already have other tests that
> might reproduce this problem. On a quick look, generic/051, xfs/079 and
> perhaps one or two others look similar to this test.

Just thought this test might be more targeted.

> 
> Have you verified that 1.) this test reproduces the original problem and
> 2.) that some of these other fsstress+godown tests do not (or are not as
> effective)?

I ran this test tens of times, but I was unable to reproduce the
original problem. And I didn't see any hang triggered by other
fsstress+godown tests in my prevous testings. So I call it a "good to
have" test :)

But if we already have the coverage from other tests, I'm fine with
dropping it.

Thanks for the review!

Eryu
