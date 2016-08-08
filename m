Received: from userp1040.oracle.com ([156.151.31.81]:51509 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbcHHR3H (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 8 Aug 2016 13:29:07 -0400
Date: Mon, 8 Aug 2016 10:28:59 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 12/17] reflink: test cross-mountpoint reflink and dedupe
Message-ID: <20160808172859.GB11291@birch.djwong.org>
References: <146914477514.11762.3144320628851923350.stgit@birch.djwong.org>
 <146914485237.11762.2526971565060691741.stgit@birch.djwong.org>
 <20160808075601.GA27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160808075601.GA27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: david@fromorbit.com, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 08, 2016 at 03:56:01PM +0800, Eryu Guan wrote:
> On Thu, Jul 21, 2016 at 04:47:32PM -0700, Darrick J. Wong wrote:
> > Test sharing blocks via reflink and dedupe between two different
> > mountpoints of the same filesystem.  This shouldn't work, since
> > we don't allow cross-mountpoint functions.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> 
> > +
> > +# real QA test starts here
> > +_supported_os Linux
> 
> I added "_supported_fs generic"
> 
> > +_require_scratch_reflink
> > +_require_cp_reflink
> 
> > +
> > +filter_md5() {
> 
> and move "{" to a new line. Also made the same changes to 928 and queued
> the patch up.

Ok, thx. :)

--D

> 
> Thanks,
> Eryu
