Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FC233123
	for <fstests@vger.kernel.org>; Fri,  7 Feb 2025 05:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904796; cv=none; b=qlkK4DtMzD7TTWDbJ6kIY1nyqh58xeQtSEX0PS6bnkiSa68EgLAltlxM4MsknlSjKJlMIkhf52HEjf3D6DX+UEkRh7+7bQesQ8Ft2uk3B35F58pwKymBV6QOrMGFMbAxFFGVExyTzyW1+Pk4xGMesXeJkBqmW4eSrDUFucQLD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904796; c=relaxed/simple;
	bh=cXu0FkBtuBZ1lLFmzeho8TO/RFsHRrX5O68SZUI0iyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+jVYJaepVhTs1/VzkWeVXVMrf0KcHeZB6IhEt37uhCJySf7KvDztY4Ak+wgArztIATg3llIsnIdPJrYj88vs0eNXzQuaL+6AaaTc2NWwFwSLKIkZCnsO7vjwQl9KWrUlL6y7G6QCVtCd8lLU5GxGDt69mQastsQRsepcPtsNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed0QFWFL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed0QFWFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2905CC4CED1;
	Fri,  7 Feb 2025 05:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738904796;
	bh=cXu0FkBtuBZ1lLFmzeho8TO/RFsHRrX5O68SZUI0iyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ed0QFWFLjBkUgy/7YzAYPNyWV4vqaMHa9YkeUBwOTuzxfD8re4YdGtogBd3FBc8+4
	 IPAhJk6p9hvbmVaJT1jhqTmYREWrV8pNC9PCS6Jzz8xNHiuUya0+kNdPokBxde17LB
	 NNJVjV1pcsyupVUU1o2QodpdRpSFWHS6tbDjAxcZZhMEORxCCsR3TzF6W6BFNFxPjZ
	 pFkmHdvnyk56+k1x+yUip474kpnLA2oIyydbJdUPaGjXmVnyyhR3GiA6243tyO6dWX
	 bPqqXc+k0dSYq2kVNd+KvOqZ23y5JWy6TH6RSPfSbhw0zv9Wu15nh++t87dIgG8+/o
	 4/OVugeHgIXfg==
Date: Thu, 6 Feb 2025 21:06:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Sandeen <sandeen@sandeen.net>, Eric Sandeen <sandeen@redhat.com>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 2/7] builddefs: define linux
Message-ID: <20250207050635.GB3028674@frogsfrogsfrogs>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-3-sandeen@redhat.com>
 <20250206223905.GO21799@frogsfrogsfrogs>
 <006e3012-c4e9-4672-a9bb-ccb726017b21@sandeen.net>
 <20250207020136.GK21828@frogsfrogsfrogs>
 <Z6WS0iAd4t8paMVd@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6WS0iAd4t8paMVd@infradead.org>

On Thu, Feb 06, 2025 at 08:57:54PM -0800, Christoph Hellwig wrote:
> On Thu, Feb 06, 2025 at 06:01:36PM -0800, Darrick J. Wong wrote:
> > sparse doesn't define linux by default:
> 
> Does it define __linux__?  That's really the preferred version these
> days and we should probably switch over to that.

It seems to do so, yes.

--D
