Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40703 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbaLPAAL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 19:00:11 -0500
Date: Tue, 16 Dec 2014 01:00:07 +0100
From: David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] cifs: Add Makefile
Message-ID: <20141216010007.5941585d@linux-y6zt.site>
In-Reply-To: <1418675045-22541-1-git-send-email-vishal.l.verma@linux.intel.com>
References: <1418675045-22541-1-git-send-email-vishal.l.verma@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Vishal Verma <vishal.l.verma@linux.intel.com>
Cc: fstests@vger.kernel.org, pshilovsky@samba.org
List-ID: <fstests@vger.kernel.org>

On Mon, 15 Dec 2014 13:24:05 -0700
Vishal Verma <vishal.l.verma@linux.intel.com> wrote:

> tests/cifs lacked a Makefile, and this caused the %install section of
> rpmbuild to fail. Add a boilerplate Makefile (from tests/ext4)
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@linux.intel.com>

This was my fault. The fix was already proposed with
Message-Id: <1418640210-16914-1-git-send-email-ddiss@suse.de> .
I'd be happy to see either change make it in.

Cheers, David
