Received: from mx1.redhat.com ([209.132.183.28]:39978 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbcERWSY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 18 May 2016 18:18:24 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7362C01FBB1
	for <fstests@vger.kernel.org>; Wed, 18 May 2016 22:18:22 +0000 (UTC)
Received: from tarantula.localdomain (ovpn-116-102.phx2.redhat.com [10.3.116.102])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4IMILqm017406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Wed, 18 May 2016 18:18:22 -0400
Date: Wed, 18 May 2016 17:18:20 -0500
From: Jeffrey Bastian <jbastian@redhat.com>
Subject: Re: [PATCH] avoid struct fsxattr redefinition
Message-ID: <20160518221820.GD23173@tarantula.localdomain>
References: <20160518174054.GA27634@tarantula.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160518174054.GA27634@tarantula.localdomain>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 18, 2016 at 12:40:54PM -0500, Jeffrey Bastian wrote:
> Linux kernel v4.5 defines 'struct fsxattr' in linux/fs.h [0] but it's
> still defined in xfs/linux.h as a backup [1].  If the files are included
> in the wrong order, the compiler will complain with a redefinition
> error.  This patch moves linux/fs.h (and linux/magic.h) before the xfs
> headers for the t_immutable.c and fsstress.c tests.

This patch _may_ not be necessary; this is also being discussed on the
xfs list and including linux/fs.h in xfsprogs' include/linux.h solves
the problem, i.e., the include order won't matter.  On the other hand,
it seems to be best-practice (if not a hard-and-fast rule) to include
fs.h first, so maybe the patch should be applied to xfstests anyway?

http://oss.sgi.com/archives/xfs/2016-05/msg00347.html

-- 
Jeff Bastian
