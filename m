Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B71E260C;
	Fri, 28 Aug 2026 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787890413; cv=none; b=BHaQw/CNm2g7PqROC1ddOPsfoJsOMiF659dfH12qV2XfjDKFQkmoUwz8hzpoAyqkCp6PAGcNVAEHSfydybLSY2kgJGSOLjeS/Yc0y90STTr9e+DmfmcE+Be6kFnauYsPCaE84uGyrZFzdDVoOiogcarjrL4Kr+FsNXt6lsFo7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787890413; c=relaxed/simple;
	bh=Swb4fHHEB1f9BaAyQjQ8M/pN0fWi7co1r0b+SFjSRl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbaGyWkbQMmLLSge9hAMuhYt+u4BSQbsEv+RimDSa0JoMFxAdhXs2Ce+L8jgz24/zgGDsxocaCcNbg7J3SRzIfUTH0No2vIvybGVDZuye8CGtnpppFurs7Rfs2hSoYydnAXrNpyAasBkTIXcd7wh7lN1dqPue522fQpN92x9PV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lWc40P16; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lWc40P16"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j4t6XYLqqm0koJPK3dJ7OW8bomyRqVu3WmA7eFYtCoA=; b=lWc40P16w66w3/SYAw06Iit58f
	UEQokhynolEFWYipa3Jt4qTJyNrdWLBQKf7WWCZEu/D4M0vCIjtiKlKY85Zr9lYqAEgbSwt3BWDEk
	bxl18wbxI0hhxnvwzNIy4moz/PYsFIaKwOj5+CJ+n6TQ7QJFTpZzRzovDU5stftAAxs2U3zWRX/g1
	QJOU5R0dLDNwd7GCegu1uocE9q3QSMqFUPQq5f64UP7Va6KDFOln1FCvZxI44R/3tWWS8jBzn/lrS
	/tB4PsfUNlrx4O5JYjdtclu4/0YgPcBzMiQMqQMkFUn54i3aZtBUD/ioBMbt+ZOPcyP1eT0y0Pgcf
	IIUOKu9w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzny2-0000000DyFe-1WyA;
	Fri, 28 Aug 2026 04:13:26 +0000
Date: Fri, 28 Aug 2026 05:13:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH] fstests: generic: Add test of seek in directories
Message-ID: <apEK5uirjyLZUfmA@casper.infradead.org>
References: <20260827234743.2389778-1-neilb@ownmail.net>
 <20260827234743.2389778-2-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827234743.2389778-2-neilb@ownmail.net>

On Fri, Aug 28, 2026 at 09:36:10AM +1000, NeilBrown wrote:
> Add a test for consistency of readdir (getdents64) results.
> The expectation is that name which exist before a readdir starts, and
> still exist when the readdir completes, and which have not been removed
> or renamed away and re-created, should appear exactly once.
> Also if the fd on the file is closed in the middle of a readdir and
> re-opened with a seek to some offset previously reported, the same
> sequence should be reported as if the file was kept open with no
> seeking.  This last is important for nfsd.

I'm not sure it's required by POSIX:

	The behavior is unspecified if lseek() is used to set the file
	offset to a value other than zero or a value returned by a
	previous call to lseek() on the same open file description."

https://pubs.opengroup.org/onlinepubs/9799919799/functions/posix_getdents.html

We can of course require stronger semantics from Linux filesystems
than POSIX requires,  We should discuss the benefits & costs of doing so
(and I have no idea what the costs to btrfs or tmpfs might be).
