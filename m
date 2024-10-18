Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D22010E2
	for <fstests@vger.kernel.org>; Fri, 18 Oct 2024 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729250890; cv=none; b=Wf8tuRWLmK07Xj69EuOIimUNqN6GxJP1J5q/4X+B55VNqJgeTKkRRU2WGxk7TsdR3pdBeb5Lhi6njZMu4BhWO4J+JE4Fq8TpJ1kmvqg7ciZYKNtHVe67okoJDlwqhmTH3W1dj3+j2mN2oTo6Ya0/ZEVXzpLDx0yTghD0+R8yoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729250890; c=relaxed/simple;
	bh=APXrs3esdRgPpQFhjqhz/l9QUxnw2e/Gn3g622dLyeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWJQhsbayNsnwOdFx+oO220ZRdS2lMfhxodE9kPDtN0QhqFbaLlV2z5tAZ3LLyjlQ8MDIa/lq66KdTDQoq08GuQqbE4XoQljdUPoBvL2fsjgIaEbcdE9WsvejBGv9ypTd6o9Df9jJ8YZizfG/ahWMw5GhVgXUqkmFULgj2p9Glw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtlWz6pU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtlWz6pU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729250887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yIro8LpypAVLSQN//fSUHzbeTiWgPoNF4Sx4A3zzrCM=;
	b=dtlWz6pUKh+LTd9XZa2W7NXPOFDs9EqihMIIWQ7fCchMi0dvNkX1XQ7wb1pN69qDduYx4d
	Ph9GRNhEQzS9OxqpMHbKf2k4GxU9a4CAHb00YFpVkFhVbAef2dajHrAXne1P8Ny5vAcUMW
	5Gs+QAykAbgYmN+9qYnTeYBKaka/OKI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-u3RRG9iWOtqrZzO90X1NAg-1; Fri,
 18 Oct 2024 07:28:04 -0400
X-MC-Unique: u3RRG9iWOtqrZzO90X1NAg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0272419560AF;
	Fri, 18 Oct 2024 11:28:03 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03F6419560AD;
	Fri, 18 Oct 2024 11:28:01 +0000 (UTC)
Date: Fri, 18 Oct 2024 07:29:22 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 0/2] fstests/xfs: a couple growfs log recovery tests
Message-ID: <ZxJGknETDaJg9to5@bfoster>
References: <20241017163405.173062-1-bfoster@redhat.com>
 <20241018050909.GA19831@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018050909.GA19831@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Oct 18, 2024 at 07:09:09AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 12:34:03PM -0400, Brian Foster wrote:
> > I believe you reproduced a problem with your customized realtime variant
> > of the initial test. I've not been able to reproduce any test failures
> > with patch 2 here, though I have tried to streamline the test a bit to
> > reduce unnecessary bits (patch 1 still reproduces the original
> > problems). I also don't tend to test much with rt, so it's possible my
> > config is off somehow or another. Otherwise I _think_ I've included the
> > necessary changes for rt support in the test itself.
> > 
> > Thoughts? I'd like to figure out what might be going on there before
> > this should land..
> 
> Darrick mentioned that was just with his rt group patchset, which
> make sense as we don't have per-group metadata without that.
> 

Ah, that would explain it then.

> Anyway, the series looks good to me, and I think it supersedes my
> more targeted hand crafted reproducer.
> 

Ok, thanks. It would be nice if anybody who knows more about the rt
group stuff could give the rt test a quick whirl and just confirm it's
at least still effective in that known broken case after my tweaks.
Otherwise I'll wait on any feedback on the code/test itself... thanks.

Brian

