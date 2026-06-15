Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9C31716E
	for <fstests@vger.kernel.org>; Mon, 15 Jun 2026 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554407; cv=none; b=keLU0blhqGLGCc8OsMV94UgRLBGLSW9Bjj/D6RJ05gld6HJSQquppWKH6qGjL7ukdM6gH8HFu0mlGwqwlNNNbMan/qEbBunqqujxPtUoRR0p65BYZipbn31Z9uB/GR9CCZw9fXeu2aOaJ5qW5Lak+OoasQYpQaq5Y92FjCyatKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554407; c=relaxed/simple;
	bh=g/odfJ+7VwEFMaNWC3j1YhZj/Qt+NAgsvHHp/tUYDgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ActxjleH7FwfhyVs+MCiXm7ozVVtRNzF6wyrMiPGlbf4av3s6syVCU4jCM4oNfJtbN+ZbGzhzkjkOfLy2sRPhR3+7MAbN0QIqngpefNp8AXfeU17J6upy5CIWGbiFbSG+1153KQFhqSmplvePlBW+cy11FZi265Rb3PZeRQNUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ans8cLQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ans8cLQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3651B1F000E9;
	Mon, 15 Jun 2026 20:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781554406;
	bh=NI7SENfv/tu0X/7uAUGajpzVnMbiW/LKvU+kR9n17AE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ans8cLQumhe1429tmtmU2YBicKuAAsz/rWJwxc++xBt9RkVAQ+CRinydZF0MfZ1hP
	 xkEYUOsbpJPswhMIOqE1geNfkDigWoYGw5wfpxQU8cIzY1+9UKF7Iwy2sh9XwXimiG
	 YUhSLWrxO2U0f8sGC0nur9wABRLYgdJmtdLZuW+G68VSK1Wre+Ly9F2jeDqgjE7C4k
	 cGgwhbmS4Fn7a731+qUAwEYFBTROCo80/xOhZVltCcO0MhtKARNqMHxSa6JhbCjoXy
	 0btx7s9MyRoJ7InZ7sUhxjdWObs/InidboIfcxa6lGpTX2dB5kLWJXM+lceNPuwykh
	 XDwKRpdz1Q/TA==
Date: Tue, 16 Jun 2026 04:13:22 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/366: check minimum dio size correctly
Message-ID: <ajBbo5LX-1tk-y3_@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
References: <20260608070010.1285677-1-hch@lst.de>
 <ai75PcdwbK7kYBTU@zlang-mailbox>
 <20260615133331.GA26132@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615133331.GA26132@lst.de>

On Mon, Jun 15, 2026 at 03:33:31PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 15, 2026 at 02:58:11AM +0800, Zorro Lang wrote:
> > > +	blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> > > +	if [[ $blksz -gt 512 ]]; then
> > > +		_notrun "512 byte dio alignment required"
> > > +	fi
> > 
> > Do we need to check this in every iteration?
> 
> We don't, but we also don't want to do an extra mount just to check
> the feature.

Oh, if we only need to run it once, how about:

blksz=""
for (( i = 0; i < $iterations; i++)); do
    ...
    if [ -z "$blksz" ];then
	    blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
        if [[ $blksz -gt 512 ]]; then
            _notrun "512 byte dio alignment required"
        fi
    fi
...


Thanks,
Zorro

> 
> 
