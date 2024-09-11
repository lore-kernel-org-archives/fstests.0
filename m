Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31ED2C190
	for <fstests@vger.kernel.org>; Wed, 11 Sep 2024 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040815; cv=none; b=GQPBhgYSeOSIxcZ59Hgntd0QVOzH+fu4RwWtU43GiEVYM8NROA6fUs1qPtD+yfWMz5JUYbISSNGSz37dbrLQqhddXVhreaq/cVnhOOPEQcJWIo+g2ZM1wv/p2AB/wQ7/2QYpQYZ0hCi6Egqw4NBqIB6AitysT1P0iWbx6XK2Z7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040815; c=relaxed/simple;
	bh=TBulQS6C29wh4KOGOO8tpxnktxJvpeqcAwsQSPqgzow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2Vl9/t3qnTjxQDF2pgG5cTS7qZU7H37SdYjGJVgaYV+OqsKv28ucAvaXD/qC2quZ6ncIvEtsgKwLuhSl5kSJIwgBQgVkYB/A/mQFCbwcvPjoHLyHA/7CYMOHEqLfvPuVbqRYOlY74CCFP0AIZzPLWt4MW5tI0jONh1jUlWUHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55782227AB5; Wed, 11 Sep 2024 09:46:42 +0200 (CEST)
Date: Wed, 11 Sep 2024 09:46:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] src/min_dio_alignment: don't return invalid
 dio_offset_align
Message-ID: <20240911074641.GA5629@lst.de>
References: <20240911035333.364961-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911035333.364961-1-chao@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

although one day we might want to do something smarted with this
information.  That being said a file system not supporting direct
I/O is a bit silly these days.  What is running into this?

