Received: from mx1.redhat.com ([209.132.183.28]:46609 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbcF3N1J (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 09:27:09 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC6EFBBB5A
	for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 13:20:40 +0000 (UTC)
Date: Thu, 30 Jun 2016 21:20:38 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] tests/xfs: test for post umount readahead completion
 panic
Message-ID: <20160630132038.GD23649@eguan.usersys.redhat.com>
References: <1467290974-13203-1-git-send-email-bfoster@redhat.com>
 <1467290974-13203-3-git-send-email-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467290974-13203-3-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 08:49:34AM -0400, Brian Foster wrote:
> XFS has a bug where directory readahead completions can occur after
> unmount. This can lead to a crash or panic because metadata read
> verification attempts to access core XFS data structures (e.g., the log)
> after they have been freed and certain pointers have been reset.
> 
> Add a test that triggers directory readahead, delays the readahead I/O
> and immediately unmounts the filesystem. This test is part of the
> dangerous group as it will cause kernels affected by the bug to crash.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

It crashed my 4.7-rc5 kernel quickly.

Reviewed-by: Eryu Guan <eguan@redhat.com>
