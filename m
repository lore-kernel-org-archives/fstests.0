Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF751AFC6
	for <fstests@vger.kernel.org>; Tue, 22 Sep 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082757; cv=none; b=BEUtNxCaK8Drn5PmKU9Y6saZizL6j1Xf+bUEBYsv+tyZ7m5CgtKnWA0xs+okrlLwnmZozDHRXuq0URhKqKctzr8XgrxZdHhEUbHay+OwlaSpetDkFI29CJbVmsosDDdmdIO3+H/6g1lrk4iBuX/yXX2kyJU4mj0OKO5KkVyVk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082757; c=relaxed/simple;
	bh=HcPO8ykzgLiHT5N3k/MojyHZ8iaPTfmdPPobL5z1yR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa01MUREsUFtkuFq7CjomSrUmyeT8MaRqOupqbGCT4K2krVXWqeNv8VKA4Sshw63sJ1C/bnVUTxXo+7OysIo8eB2RQsgEPfj9YlSyfYbEpvFgxYfk9BmRmfjC0XtNa8hbnJrgZSEduaN4fiUx5v1sV681ljcSHo3TrD/YQA0uS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7vCopc/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7vCopc/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F8A1F00893;
	Tue, 22 Sep 2026 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082755;
	bh=ulV3osTk/7bKBc5qq5ga6yZcC/ImSKyCYmso92Y7mZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B7vCopc/9Ajk77WNmxw3Kb9IgC/1ynHHhqOcEqGMV2gONMcf+/9nz1XK1Mt1UtugL
	 QEieZYtP1bzBlfKERSlHEhTz/2EiaW9AImbMxaiHuKzSQHDCS8v1xeaNr3adYUwLhO
	 xHB8sakFKvhdQCEvnr15TMum5g20XcnX2gofgg0X/wugXBXuCW0lTovqfL+EjETw9a
	 ew6KR6IdvVS9YlCKOYi6f5nH+bfil7R53zN27uxlaAG1pEPI5L7aaAqyEJMRRIPmo6
	 AjuMUjPcq/MoTYkM0OCFt9MIAHPPNA143ICBnztQIpcUcrdMtBb1FR9n7RxSEGthFL
	 dMr3/Fi7rSUsw==
Date: Tue, 22 Sep 2026 15:12:32 +0200
From: Andrey Albershteyn <aalbersh@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 2/4] common: link .out file to the output directory
Message-ID: <arJ-ZBXjy3WdWJgK@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918173218.1254465-1-aalbersh@kernel.org>
 <20260918173218.1254465-3-aalbersh@kernel.org>
 <arJ22fEt_7WtNugv@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arJ22fEt_7WtNugv@infradead.org>

On 2026-09-22 05:38:49, Christoph Hellwig wrote:
> I have a bit hard to parse this.  You mean if someone actually installed
> xfsprogs instead of just running it from the source tree, and that
> install directory is immutable when running tests?  

Yes, that's what I meant.

> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks!

-- 
- Andrey
