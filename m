Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217637A48A
	for <fstests@vger.kernel.org>; Fri, 17 Apr 2026 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411775; cv=none; b=J5OP4D0PfiJwHZ3YenTgxp+znosQgHfbwn6FGhKxzeWH2bh6YEzuIQAwZ+iG7xDdPDVU8STOvXW4tAeKqEW1KUZpalu0TqVkiXu6mREEmdVHmOAAbf8nRv2/kfQerHoat3rIlX+jQaoPfTCf4reKDTrN/nrBkprwcinI5S8+OnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411775; c=relaxed/simple;
	bh=tHsz36xN4Qt5s+4nIWkVCyjw81jrlJcTA8dq7uJ0HTs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkgijW1ZsRiNzu0bBNBCBQWWgdZxVUJPU6CivoSHR4U5rFdhMz3vjhkU3NyitGHmzGS2BAL0jopQB5/dhlSzFvH4Hr1fe5rWxYdUd7hPHkydcaGABAVLjOhvVoLwRPmgZEY61YL6kYJrfDrUqhJ4F8RigrJtyuyVfMACWRsTLu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HZwaUTu+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HZwaUTu+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0TEJQ5i1u+hzWw0Z9naqmCaEfyBLwUowXxtFdU7bi1M=; b=HZwaUTu+SCANS4vzNyB+XxG+ij
	EH3LiXNthGj5uxBiwzM61T5wM3OHcZBbHR4RQTKvpa3TyRH0r9/gUi10P7m8eSmKsM1IVXALrmJGS
	/j36olZd/golaScP3EDrrqdg7LS66BxRKITYvwSJVGTsZs4k764pqvLf1DR/fYISF9u4+b8e7pM3b
	GoPGFRaQ1E//KIHNtMAkd0Cpe26dKvpBVsNNdds2i9bznFb2jDuBnAj1QyP/BQKz93rFX5QxBNrVI
	UfY+h27HEAbkT+2tuFy/cHw9lKje6M84sHmxyvmHbj8wDDNgvNNpKlbph6dhGdViCIN8Bi4F3HPbL
	+B4oKM0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDdqg-00000003c5L-3xEP;
	Fri, 17 Apr 2026 07:42:46 +0000
Date: Fri, 17 Apr 2026 00:42:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
	Jan Prusakowski <jprusakowski@google.com>, fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, anand.jain@oracle.com,
	wqu@suse.com, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] generic/050: handle f2fs as nojournal filesystem
Message-ID: <aeHkdon2GH8UUkE4@infradead.org>
References: <20260410131821.991005-1-jprusakowski@google.com>
 <ad3zThMKaWZ65XE2@infradead.org>
 <aeER8AIJZecuTLIc@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeER8AIJZecuTLIc@zlang-mailbox>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 17, 2026 at 12:47:09AM +0800, Zorro Lang wrote:
> > > Therefore, F2FS does not need to write to the device to recover, and
> > > successfully mounts on the read-only block device. Thus, it should be
> > > treated as nojournal in this case.
> > 
> > This looks ok, but I always wonder if we want an opt-in for this
> > "journaling" behavior and/or define it clear in common/.
> 
> _has_traditional_journal ? _has_journal_replay ? :-D

Good question.  We already have _has_metadata_journaling, which is
used in this test and in _require_metadata_journaling.  Unfortunately
no one has bother to describe what behavior it is supposed to guard.

From looking at the _require_metadata_journaling users, it really seems
to be about providing file system consistency after crash.  So maybe
_has_metadata_journaling, should be renamed to this effect?

Now in generic/050 the check patched here is used to select the golden
output.  When I wrote the test originally (I can't even remember that),
it was a XFS-specific test, and Jan then later tested it to add this
_has_metadata_journaling check, which also needed further btrfs
workarounds.  AFAICS it is all about failing the mount if log recovery
is required, but the underlying block device is read-only.  So maybe
name it after that?

