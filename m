Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1533D903A
	for <fstests@vger.kernel.org>; Tue, 16 Jun 2026 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590437; cv=none; b=HebZJt2QWVADnQE4u6qvqhmt9fLEYgqm8cIpKOC39Pq79qV1DyIwIR1gNHLrnaaEEtcP/1pIcYT85IgNvnaEaTDkXcKUqWdq+mytxZNRZTMnDT/9d4aasa+iYFHx7N07YaIgJ6ddvCJwciZyt+1clroWhgqrqwkwwpxAEvx0OJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590437; c=relaxed/simple;
	bh=8m65cvfGCQDa7p2lQQqZsdfIXxNQTEzBueextNtfrIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsVUM/Qy09iMwOve57jEfr1/16w+X+f88sUe6V/p8MmNWoskGH/89B0GGMdr9HOaDLZ6jJEazLjDe2lXvoPYZntQ+RTPyMgihBUqOlE6q6a3NSGYR/h1nZG3GpfuThulMB9X94xvpHT29mutfi1WLyBfbkMLMBcgkHcZCWyza4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRsm4lwS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRsm4lwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7373C1F000E9;
	Tue, 16 Jun 2026 06:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781590436;
	bh=Vgnw8P6OyEhi7knfh0r2SbClbXHv9kU8JVoBMCqOq1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aRsm4lwSInf773y2YavThWsCOZlOmfXBkfwHrrO/wwtue+3iwPOqTl6Qsxj+C530e
	 PNsMM1HgkwI2rBcGCCPkNoQ6sp8WaWmPIv89Tr1FJ23O7nLcRLv+haMWAfBuwIba7l
	 Wn/1Jbx+8p1Ifwc6Yfm0Y/MhsVrLygC0amecS23Eh4vCkl6u3Te9oWEUI0qQPG5HUN
	 MrRkfSoTqcU0RfkwfsrglUM7qqxvZ2HfZ10q8/nHfeOkoBUubgDfSltFMUFJU6CepU
	 Tqx89MNBVxcalJdDVfqEp2WwjmH5sxdfRYk8qW3xBEl1Y3DHNze6Do9+jWSag1g3Fb
	 Unu6Cxi4Fckmg==
Date: Tue, 16 Jun 2026 14:13:50 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/366: check minimum dio size correctly
Message-ID: <ajDoebRTr8wjaV-Q@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
References: <20260608070010.1285677-1-hch@lst.de>
 <ai75PcdwbK7kYBTU@zlang-mailbox>
 <20260615133331.GA26132@lst.de>
 <ajBbo5LX-1tk-y3_@zlang-mailbox>
 <20260616052831.GA23960@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616052831.GA23960@lst.de>

On Tue, Jun 16, 2026 at 07:28:31AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 16, 2026 at 04:13:22AM +0800, Zorro Lang wrote:
> > Oh, if we only need to run it once, how about:
> > 
> > blksz=""
> > for (( i = 0; i < $iterations; i++)); do
> >     ...
> >     if [ -z "$blksz" ];then
> > 	    blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> >         if [[ $blksz -gt 512 ]]; then
> >             _notrun "512 byte dio alignment required"
> >         fi
> >     fi
> > ...
> 
> I can look into it.  But to me this doesn't really seem worth the
> effort as calling min_dio_alignment is so cheap compared to the
> mount/unmount cycle never mind everything else we do in the loop.

Sure Christoph :) If you feel that's a bit of a time sink, we could also
just add a comment explaining that re-checking the DIO alignment on every
iteration isn't strictly necessary. I'm just concerned that future developers
might mistake it for a hard requirement when modifying this test.

Thanks,
Zorro

> 
