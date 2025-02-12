Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA7271834
	for <fstests@vger.kernel.org>; Wed, 12 Feb 2025 04:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739335556; cv=none; b=KIyyyX6+uAUk8WVAlVs4OR0ou7vwBD7f+q+2XJiLWlqaYz7bJDXuwnVJPB6p5DsCmPJoubI+EmEDMtpPynWp3tazYkfdXNH/AzHdjC3T8ANeUuiQ1ZLrOvAbKFRSya8WcuwXmCQlSblPBFaNeRKMgknrOvOqUs92EKG0LWljRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739335556; c=relaxed/simple;
	bh=T5DfkCZuCSxWHJTXEfQ/TVrphYVPs2nzfCTOSMDzorI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6YAlT9Tc+o2KYh9NeN6SdOUemVcxnYSfGMmo6T1gWqPIeYvgjBWI6WwMH2g2Gvq4y/Mb/iB6QOMHvJFZvm5uzp2iWBcEbbPGWtK7u2hICCFHDRAKHI4aFjB8vbCK2FKRNdsPyAG4z4OTE5IZHy37Z32WHUpQE5kAsYprl561wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=jRDXcMdD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="jRDXcMdD"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa51743d80so5502693a91.2
        for <fstests@vger.kernel.org>; Tue, 11 Feb 2025 20:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739335554; x=1739940354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F9sKxcCyrW+nHsfUCyl8TV7iUUQiA0WPJslalU3m1kc=;
        b=jRDXcMdDsrdKd+gH2Q0FdSHJA5f0pceQJW5/VR1tUV4mqcGUj+Z3hiUAUJw3eBW1tA
         lKhp72xQlRRgvU4ZSiQ+nuJnvyk8AjI+oIvr/1bTpF27CJuDcU8AGkzskp03RHgeQx/c
         uH6b+5DFaY5qwMBjbRPmZK5afNrlqQFBh5h7l76LpbnQy1MHlEE2G7xPS1h7vORl0fe4
         Fe/4SJWNlK+OEUFK8pTWY/babDPGENxYJ3e8SgfrzAwnVjbF1NQld/LIaG7Ih6Hu/xMT
         XW63BNnCiekQlGExvS/TleqhpIhrJbq8YuU/SVs30iPdJDN9niXmziJbEmU4JciUjq3N
         GCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739335554; x=1739940354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9sKxcCyrW+nHsfUCyl8TV7iUUQiA0WPJslalU3m1kc=;
        b=Rh9MZlrw1Rjm6ilFWcKbbXnnadK7VyG3CIV2rPP9DxOjVDyWS6GmG3tFwgIm6GQYZK
         NwuE5Jcn9mffq4P9JVbW7e4tdLlUZYqVDcU2rBP5BZo1sxjcwS2R+llPCabrg425WtBq
         ecWvRrZZe02UxOXLkw17fpoKz3j3fvfOFGw2X8QTAN20MvRXNon1ehDS7F/AprtmKjBt
         tcUJ8rUolFr/v5vKUDlqNN1Fscw74DGhujs6GaN3EbaWJJeMEeLpRPGtIcaq5NwRqv7t
         8v1ZgP87LO3zQs/yEu5T2VOBEplcVv9TA4WMTV7Z1/KHVbj9k8BCs6+35dxRVYDr5/6W
         b5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCV7fBfh7fHPLadm+dEH+j5p8Y3kap/uw8YFkQD4kpoJCQaaLqwaLSJ3QF1EYOoj5QD/kzDk/MaK@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQ1YfkGUEs1UiIIak4ibFXkA2ajQBowZ323004pa/pn+caMTx
	zsbmRhjshYsjE5iCl+8LNKnzCyzZwmdZAuzvPaW0nABBFoI7k1S6RMSEmAPY0M5zstViMMraDNN
	x
X-Gm-Gg: ASbGncsK7u16MT+6pB+dQ0j9oV/HRmk5ELC7T/OokUpBP7zXowzVthAMKvBiXTTP4Ze
	S/PTCN7VUuXKEslvnsfCqWNbXnlRcz7qVMVM8eC+6rfLhiwYoe3A9AfBcDhcGfbuqvNyLzZNJET
	mmGXWOKaOZZkNiktapeu04o+Mgp35WTZ5FajGTiWujRlnUYUf15JXaWtRnRfpAvq0QhqtjRzjK2
	mMeAbYRbGP0NHnnydjcg0RCn549RbYQF66jU7MrxLt1T4g53fTTksQ9zLOQdVrbrz9Mhu8g9ZV0
	XB3fWztlOo3Ye9kOP6YKEa6IibZtlfpuodqBK7YJW+MGzS3gA4vCkOmYLkyjFbtRl0A=
X-Google-Smtp-Source: AGHT+IF3DUgK/skIqt5YhQGrfvEc3T0xyHcdYkdMlJDUMUopofHsdoCTdILcNA8XKx/b3he4y4tvdQ==
X-Received: by 2002:a05:6a00:2e1c:b0:730:95a6:375f with SMTP id d2e1a72fcca58-7322c376adbmr2789359b3a.3.1739335553766;
        Tue, 11 Feb 2025 20:45:53 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7307b136aa6sm6619881b3a.57.2025.02.11.20.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 20:45:53 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ti4dC-000000009RN-2Jo3;
	Wed, 12 Feb 2025 15:45:50 +1100
Date: Wed, 12 Feb 2025 15:45:50 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/34] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
Message-ID: <Z6wnfuqEr6TEkbi7@dread.disaster.area>
References: <173933094308.1758477.194807226568567866.stgit@frogsfrogsfrogs>
 <173933094538.1758477.11313063681546904819.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173933094538.1758477.11313063681546904819.stgit@frogsfrogsfrogs>

On Tue, Feb 11, 2025 at 07:33:48PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> The next patch in this series fixes various issues with the recently
> added fstests process isolation scheme by running each new process in a
> separate process group session.  Unfortunately, the processes in the
> session are created with SIGINT ignored by default because they are not
> attached to the controlling terminal.  Therefore, switch the kill signal
> to SIGPIPE because that is usually fatal and not masked by default.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/fuzzy |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

I thought I reviewed this, must have missed it.

> diff --git a/common/fuzzy b/common/fuzzy
> index 0a2d91542b561e..e9df956e721949 100644
> --- a/common/fuzzy
> +++ b/common/fuzzy
> @@ -891,7 +891,7 @@ __stress_xfs_scrub_loop() {
>  	local runningfile="$2"
>  	local scrub_startat="$3"
>  	shift; shift; shift
> -	local sigint_ret="$(( $(kill -l SIGINT) + 128 ))"
> +	local signal_ret="$(( $(kill -l SIGPIPE) + 128 ))"
>  	local scrublog="$tmp.scrub"
>  
>  	while __stress_scrub_running "$scrub_startat" "$runningfile"; do
> @@ -902,7 +902,7 @@ __stress_xfs_scrub_loop() {
>  		_scratch_scrub "$@" &> $scrublog
>  		res=$?
>  		if [ "$res" -eq "$sigint_ret" ]; then

s/sigint_ret/signal_ret/

Otherwise looks fine, so with that fixed:

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-Dave.

-- 
Dave Chinner
david@fromorbit.com
