Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2931AC42B
	for <fstests@vger.kernel.org>; Fri, 28 Feb 2025 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727713; cv=none; b=rWovhGcWvSr4iQBaKgGdvEVfm7JGPYRxHNunmv28uEb/AtJUFKagbPzmstbxY1T2ru0y1lPjS/ETf30TPgNI76OC+VSeiBXLGJ+cV/1C83fhSeraoHdoHt0k2hrd53+4Y6yCGSy8tvNWC5CRQdkyx/T+VH+sdeL+Ry7fpX7XHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727713; c=relaxed/simple;
	bh=7abQWjdZSz+3vZBvjS/3JrRHHIKg4Dq6sGMnwvYWcKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snIxrrpapDzmrznSwIji1nahmAVmM1DhAHO0olC3gl7FaIkr1d/RqXwOap3YrauqI66ZyPQa0vmIPT7jtYy9TRqVYhDTlkH6fenQV+HIO1XdeDUfIMhVr//jPTjFVDDny6GRncZxCrMG5nHbVIQ5RspLhvtD+C0ovNOB1ebOXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W89eSf8I; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W89eSf8I"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abec925a135so236847866b.0
        for <fstests@vger.kernel.org>; Thu, 27 Feb 2025 23:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740727710; x=1741332510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7abQWjdZSz+3vZBvjS/3JrRHHIKg4Dq6sGMnwvYWcKg=;
        b=W89eSf8I5OV52Kj8YfabcvbgIUUZsBfKOegCt/ue0Hdk4YRAewVRoLGUn/wZbXfX9i
         7JCxzIRjPPJyHiYMIo85ZLdD6hJQRK6WijCNSnf3dU4GKVUeSAOVy73dL4/4Bh4su8pN
         QGATkjB5TC3cGj60t1pu5D6a3KMlP+3ctCxStE51jPRjlN/nq0ADjlw0Oci9GsM3QdP3
         wG8eFD5dORtCe6swbDX2R+MIruUbN+xtuLoFWuUjSJGDeM8ENRvWJ+32mO7yHdYxGNaV
         60ZbEfQ4Om8RQMlVw8GnI3Ok9xsMTzlNq5V9GQkPcYbFbRq7Lw4yZZFUqz2Qy5v1MiIr
         CUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740727710; x=1741332510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7abQWjdZSz+3vZBvjS/3JrRHHIKg4Dq6sGMnwvYWcKg=;
        b=cs3ljVVPM3ULH1SN5hciHYEiyewQIfwv7sGZ+mI71+VoeTm13D3qEW/Txt84DT1pYW
         Qmg/31IlrQd6CZmw58IKzLLv+SND3SsYMazqOi+2nWXSzmxjJHQ6f6CmIAJrLESs5yp9
         zrZLliEWcqMUuqWmxwHXss+jeB21yvdlFo8Cs+G6mAH+pYqaw+PvFJbRoi5fAyk1dcJP
         Sn/Hu2GKZqAKeAqfs5ZQXOaWWObZMg/bErHFxh/MufnWYeO0+u+hp7AZzpN/HmrnzhqJ
         GI3UuomdSstYD6SL7kMIpXscgDmLfo9I2jSLWSBVHdZtNdyWRKEQwUvnYHGSiiYfHUbP
         FbcA==
X-Gm-Message-State: AOJu0YzBqB4yot30LrqRROyul90bVBXA5UWd2X5n6xvx6cUhFhqo6eRm
	USaOUkm+cR1cSDR1es8i7BejZy9/EEvcZB4IUQWTD1XmvMZXik0zo9fgmGQZyxoJSQfSvDWDXks
	5MFVtqeIeHCTKFZInJZUpL/lgWg/YOQTp9yG64g==
X-Gm-Gg: ASbGncsuV2cnFqxPW03kFBGys9M+jGZFPX5cFIbSK5fbFGSyq1rAyxmhkw1fJRI3kyT
	bMpQPOAUGwWPjC+RVGyaK8MsPaTd3/Fq6N7S33CiLiQZnz6MBTlq2On6pcDtkrcohCV5NFQUCxZ
	86e6pUMw==
X-Google-Smtp-Source: AGHT+IH4R2kwv0u7uBbeTCbIGT9I7myGSTMV0EyCvRJQSjFWiBGZ9j7Eoim4HfepcT8u4R2D8OoUZRctTV9EXm3dlfA=
X-Received: by 2002:a17:907:7287:b0:abb:b092:dae0 with SMTP id
 a640c23a62f3a-abf25d94490mr232283366b.11.1740727710003; Thu, 27 Feb 2025
 23:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220145723.1526907-1-neelx@suse.com> <20250224111014.2276072-1-neelx@suse.com>
 <CAPjX3FeKPR78zfUYGW+8Ytn-Yz+7i7k+1vmxjO6wjDcobqtocg@mail.gmail.com> <d618b303-4753-40cd-b02b-026437abdfa6@oracle.com>
In-Reply-To: <d618b303-4753-40cd-b02b-026437abdfa6@oracle.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 28 Feb 2025 08:28:19 +0100
X-Gm-Features: AQ5f1JrQfI-ebfKEktHHPxhekjNj-rUhiE3xW1tYIfMsVeEO0SQ5XlrAmW_euo8
Message-ID: <CAPjX3FfVUZ93n0fE+yNdJAQyxmf-SREz81cJifr15PYp26ABDA@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is enabled
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Feb 2025 at 07:10, Anand Jain <anand.jain@oracle.com> wrote:
> Fixed the changelog and pushed it (for-next).

Thank you.
