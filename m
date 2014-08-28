Return-Path: <fstests-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:46088 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbaH1RIu (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 28 Aug 2014 13:08:50 -0400
Date: Thu, 28 Aug 2014 10:08:49 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/3] generic/013: encapsulate remount during cleanup
Message-ID: <20140828170849.GA20891@infradead.org>
References: <1409084918-17764-1-git-send-email-pshilovsky@samba.org>
 <1409084918-17764-2-git-send-email-pshilovsky@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1409084918-17764-2-git-send-email-pshilovsky@samba.org>
Sender: fstests-owner@vger.kernel.org
To: Pavel Shilovsky <pshilovsky@samba.org>
Cc: fstests@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@samba.org, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 27, 2014 at 12:28:36AM +0400, Pavel Shilovsky wrote:
> The existing code calls remount for $TEST_DEV with constantly defined
> mount options. This can fail if a user specifies different mount options.
> Fix this by using new _test_remount() call that remounts $TEST_DEV.

Looks technically correct, but I still wonder why it's needed at all,
I can't see anything in the test that would remount the filesystem
read-only.  git history isn't a help here as the remount goes back to
the first public revision.

