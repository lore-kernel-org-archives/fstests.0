Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD784C76
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714581; cv=none; b=m78LqQqHOsS26jzK3JBkDH+C4qQtX8W2vN2Kifj8wdivFTmP3SzU3bgHNYHCeSwEcuKBFjgBbd2fBL15Vd6d1XPBSakIlAa0FqEuKSeMMIwigtFlZjTPuqCOMsrBsSKm/t1wJlfYi4uCZs998f2wahxhMTWcPSf96IzXrcDSR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714581; c=relaxed/simple;
	bh=Cd+uKXUB61+Rs2qDRYQ9HCCZcT35g5vUOabYwJ3APEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0Ky0qU9RZjCbnkI4WkJ9qeB7temsNTZIJc9u6JFR8yw1lFW95n4Ja+gdygoCDJ2+CNT1XTqPBl/s1uMaQJSoYE9RBe2TJRqlgJOgRTYmUiMprIYrWxYdR4zmdl8g07PDJTBDuxobxG8P9ctSIB1H7PtDBFRCliuT1vtPzaeLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2JdnoT2R; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2JdnoT2R"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9cd9601b8so1771912a91.3
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738714579; x=1739319379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n4o5m8k5SVq41KdniANcbRhpqFhVCx3E4Sr08VQBqdY=;
        b=2JdnoT2RTCN2opwboJDhjKuBg4wVNYS5mxr34HoFXL7HIvb8eFY4U8Zb1GMG9Wk/cV
         SUHqfDOjqM6Ltr82QeUbVL+wYIGoVciRMTVAg6C36aFpAlZvphQ2NhDkSjN/Rl007Mdd
         1NEeJNIO5K/e4HzN8C4bWsBebHpl8+gi5b8MVHBY7NKF+6cE4ZgLjTM7Aiks0IdTOblJ
         lY2Vk1d85rE096rqgxmzgeMPs86LUax5gDwWEmvC3zGnBCMOaFxlSpZxydpVph5JRLw5
         x1UbJBS6oZuRibuv/s4nKr5TBe2F3N/r8cmOjXPr5QzepNA6PJu5CZmG+nQfrIdcvoBz
         fpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714579; x=1739319379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4o5m8k5SVq41KdniANcbRhpqFhVCx3E4Sr08VQBqdY=;
        b=YU2FXr2FanetOROMJz5kpuceMCAr8jeptt8I2xhntU+9dd2YPFpTfw7qpHnLeLQNXf
         42BT9bzdjEURMqE7hxhwwy/sgOzov/+sW7XUrJtf6KdhqVes5aw6edJVq+G+jAh7PVtt
         8Xuj6fsTvRmvt2Ms6AfaAluOpvTfHDTjQdmha3VIpfPZDQD2xQic04no+SZGBn/WHNdY
         YdxE1pIb+sMPPWXPCz/7qVVKEXj0D25vzBDYgXj3qROuqnnPKhUzur07/CbH7XSWoRWk
         2On6J1qhtZdqhzB/u1vZyB2UFAeZaC3woPMdsKbK4rdEKzJMk6QSlh0Ctog/vha9WVWU
         8BwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTTFYb4DC/NoknVCu6RWbqj1ahtARZGFS1UBeqr6reB0wWmRBA1rffeLAINS6q73NeEbhrckIC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Ckikraj+ozdIZSK36wdsh6LzmI7JsUQfj69UOT0ERiH0A8bY
	vcWIykNWkhGhmMFvaBxipQqjqt0VJjSCPx+H03iVmsZx7x4mBYYh8AyL7nFsEgO8zeqeuR1f9bJ
	p
X-Gm-Gg: ASbGnctGXy1CAOcal81OOH/xr+7JUTyVKFkxSCMQIHiQWfYpqk4+CBEIenxp7t7BZuB
	u49JZLv+da+pn3C/1YWaX6SkiU9wzU/2MPAnczQay1LCDNMkim9xHaQDhXD3Arkefws0SOFc0Q/
	3+ybiF3bGqsNuUQNJ6HRD3B5gNfM4LCQbGaYq6Hu0SzAWzqWjTaRQaDe7XnNQQR+NL3Tcvc2eXB
	4HCbSfxycZq77mBnpCmS70ZK8UZDv8H/qt2182zKhvRU1JB8aOtqOvMCDCV8QqPuM3j/BDWgAKf
	mn+LZsGCtrVr+EkpHF9cdlvWNDQAgPtjjSvygt+baAO28Zw6iNWZ9oKq
X-Google-Smtp-Source: AGHT+IHDYFDOJ3DkXWCHGTIxgcg8DhvgEEWomWTxjCa+lXLNvZ/ZsWU2hsmK0SxQGVW2IIxlnwrdvA==
X-Received: by 2002:a17:90b:2fcf:b0:2ee:8ea0:6b9c with SMTP id 98e67ed59e1d1-2f9e076d86cmr1414610a91.12.1738714579555;
        Tue, 04 Feb 2025 16:16:19 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1c06393sm169208a91.0.2025.02.04.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:16:19 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfT5V-0000000EiqV-03Nc;
	Wed, 05 Feb 2025 11:16:17 +1100
Date: Wed, 5 Feb 2025 11:16:16 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/34] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
Message-ID: <Z6Kt0Khj0hF9HX15@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406291.546134.15020436171673463354.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406291.546134.15020436171673463354.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:25:26PM -0800, Darrick J. Wong wrote:
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

Change looks fine, but _pkill is not yet defined. It is introduced
in the next patch "common/rc: hoist pkill to a helper function"
so this needs to be reordered.

With that done, however:

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
