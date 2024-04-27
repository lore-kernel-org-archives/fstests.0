Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F31E4A8
	for <fstests@vger.kernel.org>; Sat, 27 Apr 2024 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714197182; cv=none; b=T7BeY2frMIw7+8h7fWqKY12PomFgvb2hKQ8iEhJDFJXNyBljVPJtbM2U7Gzs3WozURvDuq0rRTo/D95pjuAbvZZJ3r/KUitZAjqe8FlPUUV8D5ARm+2KPQcPq0X3AuLPGzA5ZkbfOg3SEOW5IWB6lY4G+zpiR1dXFVGXScfgEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714197182; c=relaxed/simple;
	bh=oKCtNHj1C295ttniAlh0fsPBUDv86o5UFfUlMDV1I6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOlnAnTOxFPvvWaZrBnFJjGG/kLf5I9DSaje4j0QtnXsn5l6FjK0EO05x1JrYf20VevgYwIWDDorNJUFNytN1OoASGMIc1bTSMroVjDpibhUgGw4eXyPksbTeYO3fhYgGq2L28GwOJpoStQz9rdJ2j7eOLe1hOaaIQNAE4keuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mRw0mMYy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mRw0mMYy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qbdvlf/6QJsmLzHj84Tg4MKZA5jraFdBN0AtvDM1tVY=; b=mRw0mMYy1KbK0O2O/gxMMgfZQi
	eJ7OA+h72NzUSVg8IzK4lHMHQUy5/f5k8a7Mq2Gk6Y3oyBJQ4gUKmMKaYLK+wtAk7WtG0u1ZhLEsg
	vDwNh0S8N7gS91uO1vFX0UCDy1uUIvDh2y71FNL3g6VvxwUmPFm+fDzjcU/x8CkDhpWl+vA9JQWKG
	r3fVsffx3IgsHRrNQa05AKj5DFdjaxz+K+rMAyjGmoweZT7mCEkNneBWefehPSklzpB1m1CgubCHY
	644CDzffQd0O0cNBj15yk5kfJ2BVoBN+/nWw3Hl8K8loFuTEifhZAVjC+y1nOcWp/n4f02zkgI4cx
	8wff756g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0azb-0000000EvL0-3dnS;
	Sat, 27 Apr 2024 05:52:59 +0000
Date: Fri, 26 Apr 2024 22:52:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yong Sun <yosun@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: solve no-return-in-nonvoid-function issue
Message-ID: <ZiySu-TX-5kR3VOx@infradead.org>
References: <20240424112444.20964-1-yosun@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424112444.20964-1-yosun@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 24, 2024 at 07:24:08PM +0800, Yong Sun wrote:
> --- a/src/fake-dump-rootino.c
> +++ b/src/fake-dump-rootino.c
> @@ -221,4 +221,5 @@ int main(int argc, char *argv[]) {
>  
>  	munmap(header, GLOBAL_HDR_SZ);
>  	close(fd);
> +        return 0;

This needs to use a tab instead of spaces.  Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
