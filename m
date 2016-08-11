Received: from bombadil.infradead.org ([198.137.202.9]:36891 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105AbcHKRpg (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 11 Aug 2016 13:45:36 -0400
Date: Thu, 11 Aug 2016 10:45:35 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] src/t_immutable: allow EPERM on immutable inode
Message-ID: <20160811174535.GA31540@infradead.org>
References: <1470741408-32689-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470741408-32689-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 09, 2016 at 07:16:48PM +0800, Eryu Guan wrote:
> Starting from kernel commit 337684a1746f ("fs: return EPERM on
> immutable inode"), EPERM is returned instead of EACCES. Update
> src/t_immutable.c to accept EPERM as a PASS.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
