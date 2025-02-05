Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C139C2D1
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714626; cv=none; b=eQR5u7O4qAF3MiUe2j91LEudF7pwVy0RV3HpdIypYKn+7GTOLfip0nIP1E4Zj3S6vmfrClE4I0LS6HLgLYFBr9TbmU97XOtudsYWRHFaZ/pTbRLSlkILV1eApWutG0sUaw8IxitKyIeSDwxdn3sdhC4OfvHIiOACW9EZ34VyvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714626; c=relaxed/simple;
	bh=eVAJEdLuQUb2bLju92QgOKoEHpfCuSg9j/OmZ5BjfDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iySpLV3+KXQjGygvj4a2u6RIEm3TexN2wWIMyC+FkMrioA0dQFhwJYdsuHRzLsLnhYPJDH6h9P2fHwkCtC3u8pZJCKIcSuk+Ll8hf88uJg+uD1o1tofjQCIXD9+qMPrrIh7gJiCYtNfQWOb9fJcpUHFpN8IxWs7z5kyvLrZflTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Qo5jp5u4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Qo5jp5u4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215770613dbso85160895ad.2
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738714624; x=1739319424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EX4MUvPk7++0CldMOisGfO61xmQCFSwC1NdOvlvdD4Q=;
        b=Qo5jp5u44PyRRPTsDnEXyAHq8SIY7N9gb0WTtGZrIkJSoq2XJhiU9cimGgbcQUXvzB
         rniv4K87J67/r0UbdaO2QmL9U6O6reXYSPngIRYBNYDEFpzoPWjQcglQ9LP6Pig69PC9
         8Ts32xlNTbba/XRfghJXKoPOv6NwV2+jVCX6pksG+oaghvygvh4kIv2Wb5IojU4MPLrE
         /aEYfDJp7h/QkuUdqRoh30Em5IO5TcZfspkc2jkPLrRYfC0/UGib45squx0osbJDufnQ
         22Zqi9gT2jwVipvntN4tJQ6Sm1sM39ozkT+cGVxuo7I35YZ005/BKRvbIHXA/COK54hU
         hqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738714624; x=1739319424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX4MUvPk7++0CldMOisGfO61xmQCFSwC1NdOvlvdD4Q=;
        b=BY2zNBqbtpfdyfO9+Sx+86GzR76L7qbNEpEH5H3BNvozgwsNQjQLp8pp7oU/N6Uu85
         YedwVILMN+FEWa0dx3iAT0e/s5nWhI6t4bD+v2cFuvOwt8cI/xyvYFMxm8ETP56RvD/5
         Cqv6ZoO3wrTUF6jSOKfuZcvP6MCRZDR0D+2EyzDmpheyHCIQBPj9ekTEi7JHxfdi4Ol7
         /Dreh7piKdqonqNaF9HEMt43nMKmrDHj3aclEEU8S67RAcQSltoZZ5gZOI/6NzMThOdD
         QcyW9fm3JO5DuiA6Tma8Aa6zTa1KH5BKxBV0zi+9aPSWhYfo10qGodv6q+Xq/qRkBFuN
         YWLg==
X-Forwarded-Encrypted: i=1; AJvYcCUAmtiy/aoG+wXW0SirAO8VB1axgwEQHVRTdVlg8O1IzbKfnOK/P6tf3yhtyqLq9l8h4MjCMslb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65Wo0oqxI1PkyXQedAPmX2ZWSSarGpngfuWaCANexiCXOGJ+5
	Bn65ti4T+iET774Uv8LfejPcJIDqFduVgK5EuMeKouwJ4haguWm+jf62FY+wfL4=
X-Gm-Gg: ASbGncul2Ckqv20Cz2jw0MCxS7YuJk81T1m3B92iY1FL824zAbJ9NDgzfKm0TO92/Vc
	Dg/SMsEgXXQ2zX+TAbG0a5wb5nqV4sVPF6h8wi4UtA4QwtnLUwxBqrZQ8AS3IgqUTXHBCPfTPKe
	5JS4JqkApZRk1+jbLeAoVKbMgNKSrBTwl8AJ764/NJc3d4fBUEcSGARMJOUva2NnG/DDXNWE0gm
	n8uzjoYb8maSRPBHo6Wx6vTvzOKqoIQEUdONAvZmrDXfghxjR4xvZxvsMUZZlfBPx/F2BY+S0GN
	QQHNfLkUR2OOoiiSwdPGZ1S4tbJm5FVd8wBBgakP35hnmre1utO3yhbD
X-Google-Smtp-Source: AGHT+IF0fGPoZ0o6c3/KifK+4vDFyDlaoMwLReG+Nq+K4DdtJ4zbe4B3HobDOfBADRTDpH6K5vAagw==
X-Received: by 2002:a05:6a00:a82:b0:72f:f764:6269 with SMTP id d2e1a72fcca58-73035125686mr1367074b3a.12.1738714624286;
        Tue, 04 Feb 2025 16:17:04 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cea77sm11138362b3a.150.2025.02.04.16.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:17:03 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfT6D-0000000Eiql-3Ap8;
	Wed, 05 Feb 2025 11:17:01 +1100
Date: Wed, 5 Feb 2025 11:17:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/34] common/rc: hoist pkill to a helper function
Message-ID: <Z6Kt_X1AliA1_2e6@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406306.546134.16510101936129304399.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406306.546134.16510101936129304399.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:25:42PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a helper function to wrap pkill in preparation for the next
> patch.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Looks fine, apart from the ordering issue with the previous patch.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
