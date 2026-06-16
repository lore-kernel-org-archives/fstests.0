Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6ED3CF677
	for <fstests@vger.kernel.org>; Tue, 16 Jun 2026 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587717; cv=none; b=MpznPfgdPLSBBTgkg0FET7ucLFdgkrWi3UDEXyl+gGUnJ9nNvdNTbPui2s7ERbrW7zguVXTPhmtAK5Ytj6BzyadPrUkiSoCNb15hbS4XxDPbTx0Sja/j6N5+e/5SrInlAUMNS55i+vC9RpxGV+F+hd1pBb48eM9KFDmZJn0QQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587717; c=relaxed/simple;
	bh=X9oU/cDp6K3RJ+U6JUFVSnmnUIQtDRO3QTi6qXQSRoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEV5tvjVSe8O0Y2ARvwPiw7lYLffqUiFBrVYov8Jr2kuBU62L5fQUWB7g0LSedowgtcHWVVEbL9N8A9Tfl2of/PWJZKEGpP26zXD9rpK8sCfVpnURopK2SwQvoKzr+pTyCMHXbKDV54fMrwxKzdGLJkmBGECWFxAzKQJSFWVf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9857E68BFE; Tue, 16 Jun 2026 07:28:31 +0200 (CEST)
Date: Tue, 16 Jun 2026 07:28:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/366: check minimum dio size correctly
Message-ID: <20260616052831.GA23960@lst.de>
References: <20260608070010.1285677-1-hch@lst.de> <ai75PcdwbK7kYBTU@zlang-mailbox> <20260615133331.GA26132@lst.de> <ajBbo5LX-1tk-y3_@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajBbo5LX-1tk-y3_@zlang-mailbox>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 16, 2026 at 04:13:22AM +0800, Zorro Lang wrote:
> Oh, if we only need to run it once, how about:
> 
> blksz=""
> for (( i = 0; i < $iterations; i++)); do
>     ...
>     if [ -z "$blksz" ];then
> 	    blksz=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
>         if [[ $blksz -gt 512 ]]; then
>             _notrun "512 byte dio alignment required"
>         fi
>     fi
> ...

I can look into it.  But to me this doesn't really seem worth the
effort as calling min_dio_alignment is so cheap compared to the
mount/unmount cycle never mind everything else we do in the loop.

