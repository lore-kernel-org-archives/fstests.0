Received: from bombadil.infradead.org ([198.137.202.133]:54504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfGXO4N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Jul 2019 10:56:13 -0400
Date: Wed, 24 Jul 2019 07:56:12 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] generic/062: more restrictive namespace for getfattr on
 cephfs
Message-ID: <20190724145612.GA18853@infradead.org>
References: <20190724145511.1155-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724145511.1155-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 24, 2019 at 10:55:11AM -0400, Jeff Layton wrote:
> cephfs exposes some information via virtual xattrs and their presence
> causes this test to fail. When running on cephfs, only search for
> specific xattr classes to ensure that we skip the ceph.* ones.

The test should fail.  Filesystems should not make up random crap in
their own namespaces.
