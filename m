Received: from bombadil.infradead.org ([198.137.202.9]:34880 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbcGEJnG (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 5 Jul 2016 05:43:06 -0400
Date: Tue, 5 Jul 2016 02:43:04 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfstests, ext4: add project quota attribute tests
Message-ID: <20160705094304.GA30163@infradead.org>
References: <1467701791-14626-1-git-send-email-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467701791-14626-1-git-send-email-wangshilong1991@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Shilong <wangshilong1991@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, sihara@ddn.com, lixi@ddn.com, wshilong@ddn.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 05, 2016 at 03:56:31PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> Some basic project quota inferface tests.
> 
> 1. ioctl with/without project.
> 2. project inherit attribute.
> 3. Link accross project should fail
> 4. change project ignores quota

These looks pretty generic.  Aren't there any XFS tests that can be made
generic now that ext4 supports project quotas?  Even if not these new
test should be made generic and added to the generic group.
