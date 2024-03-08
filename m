Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7231EB4A
	for <fstests@vger.kernel.org>; Fri,  8 Mar 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912602; cv=none; b=uODhM/zjmQMMRV3uk2WLaznBT86BQ5HtVWIVv4a8Gu2/eeaYm4T5FQyuNBMSUs3xUGngklQnLfvc0oudK8DoJ4obO4z3P+lJEJ8sLUHBX0Euoekdeek7oYq+cYk3ihRdkWziwQFflqBu53QrcWRsaNRoY6+dhSgF7DpMdV3yioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912602; c=relaxed/simple;
	bh=i6wsA3cdbeeEgg3gWTh10Gc9alep19CB2xCU6OkEj10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjPIWtSn1kTmJeXZA6ZyfzVVyFhVCRzQLy2OirMXB3r42ZHi9mgvufFLyhNsjqy8ErtvR5wH8ThDSfvnvxvR4KBPFU9Uta3FIX8g0vv0tFSxzi2FjROc8GseTwADvy3ipZ/nVeUeI0wp8e/B1T9Uh+VMikKb1GUQ9SnWgLCmlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E238F68BEB; Fri,  8 Mar 2024 16:43:16 +0100 (CET)
Date: Fri, 8 Mar 2024 16:43:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zlang@redhat.com,
	fstests@vger.kernel.org, jaegeuk@kernel.org
Subject: Re: [PATCH] generic/392: stop checking st_blocks
Message-ID: <20240308154316.GA13600@lst.de>
References: <20240226100319.280355-1-hch@lst.de> <20240226165206.GP6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226165206.GP6188@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

Zorro, I noticed this didn't make it to the pending queue, can you
pick it up?

