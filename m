Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657EE26529E
	for <fstests@vger.kernel.org>; Tue, 29 Jul 2025 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774934; cv=none; b=Dua18+XevftW4FpQqa7Wu8qycEeyBGRLl1FEqaneTlJSxhWV61XkG9eTCOh3hqDeWudvrxQWPZSNFau59KZMF3YWNR1RtPwLp3BSH93i9x9xZBTtDtIy2DL56lRHjYsdIk31beXqpn0l8KBJnzls+J7XT6nN9goGUQzINFQSgqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774934; c=relaxed/simple;
	bh=j7VLDpXCMu20D4Sa0Qcg7yI4wgZmnRspazoQU/a29OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9uNZ76PiibFuG6a0fWuNxvCoP4TW+1s5eLIl+yUASdq+6cvsDmj+scYn7aFUsh3eVz1zZN0QiQ9XglsTQVXd9MWonYkXZAvSSlKbTxxInc2FcJXQmxzg3w1EJQw0pv4ZUGoUHp5fEZcpglMK1ThEBltSTQc3tkFrmtgLvW1SJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17AF068C4E; Tue, 29 Jul 2025 09:42:07 +0200 (CEST)
Date: Tue, 29 Jul 2025 09:42:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org, Yuezhang.Mo@sony.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH] Revert "generic/730: add _require_scratch_shutdown"
Message-ID: <20250729074206.GA23612@lst.de>
References: <20250724072514.3313006-1-hch@lst.de> <20250725133753.f7vwtkvtxql4owl2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725133753.f7vwtkvtxql4owl2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 25, 2025 at 09:37:53PM +0800, Zorro Lang wrote:
> About why this case need "shutdown":
>   https://lore.kernel.org/fstests/PUZPR04MB63169A8C1008035BB2D104568166A@PUZPR04MB6316.apcprd04.prod.outlook.com/
> 
> So looks like we'd better to notrun if shutdown isn't supported by fs on
> SCSI_DEBUG_DEV. But if think "_require_scratch_shutdown" is a problem, maybe
> we can avoid using _scratch_ things, use a local function to check shutdown
> on SCSI_DEBUG_DEV manually, and notrun if it's not supported?

These are two almost entirely unrelated, except usually sharing some code
for the implementation:  _require_scratch_shutdown checks for the 
IOC_SHUDOWN ioctl, while this test coverd behavior of the file system
when the underlying block device is removed.

I can't really think of a feature test for shutting down the file system
on device removal, because it really should not be an optional feature..

> BTW, can I ask why do you need to test with TEST_DEV only :) Although
> SCRATCH_DEV is optional (README says), I think nearly all testers test
> with SCRATCH_DEV.

I'm working on an experimental xfs change that will need a lot of
tooling changes to handle the various scratch mkfs use cases.  So
while it's still bleeding edge I'd rather get all the TEST_DEV testing
than debuggіng/fixing xfstests.

