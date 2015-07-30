Received: from bombadil.infradead.org ([198.137.202.9]:37185 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbbG3RL2 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 13:11:28 -0400
Date: Thu, 30 Jul 2015 10:11:28 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/6] xfsprogs: avoid use of si_tid in struct
 xlog_split_item
Message-ID: <20150730171128.GF25395@infradead.org>
References: <1437913255-7524-1-git-send-email-tytso@mit.edu>
 <1437913255-7524-5-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437913255-7524-5-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: xfs@oss.sgi.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jul 26, 2015 at 08:20:53AM -0400, Theodore Ts'o wrote:
> In Android's bionic libc (as well as the Linux kernel's
> include/uapi/asm-generic/siginfo.h), si_tid is a #define to provide
> backwards compatibility for the timerid in the siginfo structure.
> This breaks the compile of logprint/log_misc.c.  Change this to be
> si_xtid in order to avoid a namespace collision

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
