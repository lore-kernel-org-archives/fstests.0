Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90653B27FB
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774213; cv=none; b=QFat2MTnfVJHVs/VQBvZYavAj5Kllzosv5PRXgZfbEQJGrHVaZj4Quml4ZCrvGLdMsz8NjWgosqkVu9+rl3rzMQDhCEpiOs0UrcnnaYM7K/+g4LRnOXVOxHEwFIpVGCTWz4ULw8/Iv+gw/A78RJE/TQlGCYpTtQ48cnQkgrV1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774213; c=relaxed/simple;
	bh=Wl2om8naXVIrI0X70knQT2S7PdUAWE5IiWwPRnFcc1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n7//Wg3UfYif2Habyk3RNUdfnrKx40T+Vovc7l4HfaZG8AuS7dKi+hwWGUFby6vcH7+hSVi69yoGr6khtAmpDawYrrdZoXd5OpSWf6MSzJ5KcFDL8R9KideaNms0lrYiHNnYJKENJoySkugGIyF/ybnU9OOMuxz2bfoSyLY8Z2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJpSVpXt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tg8ZO9HJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJpSVpXt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tg8ZO9HJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787774207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pg1TY+pjHjq1HLuqWTw4Sw4XUZxEuLyeU2S7m4VVGvc=;
	b=KJpSVpXtHlucF/kY9iefnN4C2k7bcypIkp3ZpAG8fUx4HA7Y1ayxsa6mCmyy5Ks3dXHpx7
	0NH+OOyMDGW+PykKwfaDx+eufasnXm6CYodCS/1KrR08CtITPKxb7376xlMDUsQOWUC7KY
	YuzUzj4LzgVMc0i+A72YpnuS9P1KHPM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-gtK4_JdXNHuUp_Ejh87uIw-1; Wed, 26 Aug 2026 15:56:44 -0400
X-MC-Unique: gtK4_JdXNHuUp_Ejh87uIw-1
X-Mimecast-MFC-AGG-ID: gtK4_JdXNHuUp_Ejh87uIw_1787774204
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9372b9db132so125915585a.2
        for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787774204; x=1788379004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pg1TY+pjHjq1HLuqWTw4Sw4XUZxEuLyeU2S7m4VVGvc=;
        b=Tg8ZO9HJckUp2oTY8JeaN05uaa9ouLWVqkUYj1X04HjovSl10Vw228vYxpZsHhJzm/
         0zUHlYWmMNVhPIJ8rY1fzchIxUzZR09GJSXCRDzMj4CXBJa4h9mxgsubgC9CPUMUhi8h
         ZWaTf+ELBrWVsU5TucxMQA/ei0VenIkVBSfCeXQXHtsAGhlpsW9ruSmncadHO5zV6R7y
         TeNTXZRnBtmoJvhYXN9bsf/xcBIzJjMudjy7LmXIrp7SS8NflT9BfIm9o5w1FL462KBw
         aSgBtC1wsIwu1PzPXEoEfCrMXCdR3QKZHIv+e+qHQsedwaAPMhOp+7u/VZ/ZpmIypcps
         f9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787774204; x=1788379004;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pg1TY+pjHjq1HLuqWTw4Sw4XUZxEuLyeU2S7m4VVGvc=;
        b=J/V5EwOuVciUyNPMAv5envFtzuhUq58rthzTGyY+ttMDQxETbDKZCmLFgkJGt6ISMh
         yxP7kYT9eeQxrRgth0tpBQHmwUWZsslM3IKxoPCdnswk1r4USO/jf5PFU6Kjmyp/2n+H
         SLr3fwirhJziEHCjh3U7h9AX/HDE9TJQh5yYV5s//uJfMwD8LcRA5fjlbD5uKT5ct1vL
         RuP+RDKLB1cvlLzADsa6C3LQqoUhAXINBWa50lwU+U1CGDcAzJNtoqxoOKR6QtHwkQiL
         N41E9GaOj//IQDrDXy9bHs+st8ROBZ9dV1e1rasTbsC2LpUHg0hkwmGkwYZUIirh1CZa
         Tccw==
X-Gm-Message-State: AFuF++lx6aLu/4IQpNbAtZkK4o1SVl4pZ9Y3Gj2Fiq20eeG7vUDJDCtK
	OV0iZQLtNSCVBf9itJrE4bUkALQu+n+SWHjtjUHVqRVyvSH4XeWiYQNvNrRx5arYojxTjGiOuCm
	7noS9hLXaLMudnqNUcfBo052e1Z/wjrwTYNh1+xcWJZRvKJEVcNRSXv1TDtXTfyRzwSfpOqeo1u
	ajTeAtwcyLOFtYQl3TyY5uP5x+XmCFpS3OlEIz0s5mjai/
X-Gm-Gg: AR+sD13NSIv6ve8ayPl8rq2ABStO8epwApHcY5DG9Z7Smy2ZJo8imjkSDspQu4FVpHD
	pmqN5nEWyzZZ5eZQA1M6LrCrbXRiU4KnswPLlzVCGjPpBxjTfZfENoEJ3R5qx3B40/KXPSXOPvq
	2VBxO1tfNE5B0rJZBYbKs5NDuel4rRqaznlWOc1/iDspwEQbbR7c881FHPUWBgGURGq1ddhxSrQ
	VL65da02D1WoFXJeopcW9igjoZpYL7yEXnEyCTq4afAr+tOTFA61Oo/xrc+G/iLePxvKBrQ6IAa
	o33Sh/zXXm+/cqCB+isXtH+LS++Y8Qgc3KEKQmKsfcvPuInA10xai85AUIDmHlqndGVoh3mGSML
	U2H4ETlP2/53kDaj0LB52u2lQuVo9Noa9CSv1jSWA
X-Received: by 2002:a05:620a:2255:20b0:92e:4bc9:6ea9 with SMTP id af79cd13be357-9377fe2fa36mr727189785a.0.1787774204207;
        Wed, 26 Aug 2026 12:56:44 -0700 (PDT)
X-Received: by 2002:a05:620a:2255:20b0:92e:4bc9:6ea9 with SMTP id af79cd13be357-9377fe2fa36mr727185285a.0.1787774203636;
        Wed, 26 Aug 2026 12:56:43 -0700 (PDT)
Received: from [10.0.0.119] (97-127-68-83.mpls.qwest.net. [97.127.68.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e616f32sm284262885a.26.2026.08.26.12.56.42
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 12:56:43 -0700 (PDT)
Message-ID: <ecf63a4a-2e6b-42cf-8a58-51780630b3fd@redhat.com>
Date: Wed, 26 Aug 2026 14:56:42 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] Add _require_chown as needed
To: fstests@vger.kernel.org
References: <20260825001337.449670-1-sandeen@redhat.com>
 <20260825001337.449670-4-sandeen@redhat.com> <ao8dOPXMBJtSbTXv@zlang-mailbox>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <ao8dOPXMBJtSbTXv@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/26 12:52 PM, Zorro Lang wrote:
> On Mon, Aug 24, 2026 at 07:11:10PM -0500, Eric Sandeen wrote:
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
> I doubt there's any filesystem that supports `chmod` but not `chown`.
> 
> Reviewed-by: Zorro Lang <zlang@kernel.org>

Yep, I'm not sure why we have both helpers, tbh ...

hey, you asked for ful _requirel annotation so .... ;)

Thanks,
-Eric

