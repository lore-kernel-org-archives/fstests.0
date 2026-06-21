Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96A3C07A;
	Sun, 21 Jun 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057309; cv=none; b=iIg8IA78yo0thyKqvGMqR9ZGYQ64eCEbyzhbP7MJ/lBnSiTEiJMQ+1ACjp6tgsX1vZp/AaAK4Ye78STsV3wD/o4fhx1KFHwhodA1Zz7odKRQ3dMXNL+VcZyNIpuhzttUUWSD44kDM1RT9RswBqj6LSC/kzwLNXG+uCj5djxo9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057309; c=relaxed/simple;
	bh=TnxqZqCvx0LenqLDt39PokxIBq+58bRZw6b7Lmb9HXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txzy4C7QZwyOuEmllx2zQKiszJO3EXKiGWWx9iOQwguHbYBCL+G6v8z86XrhkyuapnoZ/gKpq06zqUAseqGgycREzSYpb5dvBUTDJ1nWr3WmItyiGW4XlZzIwCCqYEk58z9WFHtgcimH9jBvPYBn0pgrVit8kO8U8+5f7r065Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5+7+UbS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5+7+UbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7F11F000E9;
	Sun, 21 Jun 2026 15:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057308;
	bh=RhD9pOzKgJ+fxdq12M8bJQPH1oR4tcbRlXQkz5LgoyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B5+7+UbSYuq+VahzxEKEv/fNcapKxz2NVdfCqhGRBY5LOns95PdIdmZ9W/b4LPR/R
	 6qSUXAVAdXFSxvyTrsrAzH+qTtzTClqji/5Je8SeHsqvjVfvc/5T2zSDHzcIlGmnYP
	 DpRzQWvNtuHI6b+Jg5B1IypoFPl6kF7nxuJNngP/Hwej2uNBSLHiDldsDwHuqTcm3L
	 d7HB1U5lyQLHlDIHqFkbpihjaGv2uh6n9PtnOWtoXRty/J6lQkFg4v/c3v0qM66MRH
	 xDwuxxS9Ben3qFpKBpfHuIgXhagywDwaPD+0iW4q7UdArM5vN09xdu4LlKM5ric39+
	 hds72tVsNk58A==
Date: Sun, 21 Jun 2026 23:54:58 +0800
From: Zorro Lang <zlang@kernel.org>
To: German Maglione <gmaglione@redhat.com>
Cc: fstests@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/633: add _require_acls for tcore_acls() ACL
 dependency
Message-ID: <ajgIp_6kmKxPpZuP@zlang-mailbox>
Mail-Followup-To: German Maglione <gmaglione@redhat.com>, 
	fstests@vger.kernel.org, brauner@kernel.org, linux-fsdevel@vger.kernel.org
References: <20260618-xfstests-tcore-acls-fixes-v1-0-45a1aec1d99d@redhat.com>
 <20260618-xfstests-tcore-acls-fixes-v1-2-45a1aec1d99d@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-xfstests-tcore-acls-fixes-v1-2-45a1aec1d99d@redhat.com>

On Thu, Jun 18, 2026 at 12:11:54PM +0200, German Maglione wrote:
> generic/633 runs --test-core which includes tcore_acls(). Without
> _require_acls, the test fails instead of being skipped on filesystems
> that lack ACL support.
> 
> Signed-off-by: German Maglione <gmaglione@redhat.com>
> ---
>  tests/generic/633 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/633 b/tests/generic/633
> index d75d4dc860d3b78e5fe11b538e3aba4e9ab477e1..90d24f099bc732d5db209f8d014ddaeb042985b2 100755
> --- a/tests/generic/633
> +++ b/tests/generic/633
> @@ -14,6 +14,7 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
>  
>  _require_test
>  _require_chown
> +_require_acls

_require_acls is in common/attr which isn't imported automatically.
I'll help to do:

  . ./common/attr

when I merge this patch.

Reviewed-by: Zorro Lang <zlang@kernel.org>

Thanks,
Zorro

>  
>  echo "Silence is golden"
>  
> 
> -- 
> 2.49.0
> 
