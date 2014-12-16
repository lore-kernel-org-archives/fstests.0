Return-Path: <fstests-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41452 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644AbaLPAl5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 19:41:57 -0500
Message-ID: <1418690516.28265.1.camel@linux.intel.com>
Subject: Re: [PATCH] cifs: Add Makefile
From: Vishal Verma <vishal.l.verma@linux.intel.com>
Date: Mon, 15 Dec 2014 17:41:56 -0700
In-Reply-To: <20141216010007.5941585d@linux-y6zt.site>
References: <1418675045-22541-1-git-send-email-vishal.l.verma@linux.intel.com>
	 <20141216010007.5941585d@linux-y6zt.site>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org, pshilovsky@samba.org
List-ID: <fstests@vger.kernel.org>

On Tue, 2014-12-16 at 01:00 +0100, David Disseldorp wrote:
> On Mon, 15 Dec 2014 13:24:05 -0700
> Vishal Verma <vishal.l.verma@linux.intel.com> wrote:
> 
> > tests/cifs lacked a Makefile, and this caused the %install section of
> > rpmbuild to fail. Add a boilerplate Makefile (from tests/ext4)
> > 
> > Signed-off-by: Vishal Verma <vishal.l.verma@linux.intel.com>
> 
> This was my fault. The fix was already proposed with
> Message-Id: <1418640210-16914-1-git-send-email-ddiss@suse.de> .
> I'd be happy to see either change make it in.
> 

Ah, I didn't notice your patch, it seemed to be threaded under a
different conversation. We can ignore this.

Thanks,
	-Vishal



