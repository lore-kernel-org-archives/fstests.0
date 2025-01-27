Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F451D7E31
	for <fstests@vger.kernel.org>; Mon, 27 Jan 2025 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014212; cv=none; b=ZDnrhOMAfHc5/3XEL6tvDwE5LfFHaINKqVB06sge2oudV/WFK317JjF/P/zjPXXdbzfd0W7jtfwBBn4yqidd6cfmT75pYVT0nwlbNYyRD2N7S545umEfBBGqbgIoMUlHKxVV93oR3i1eTfutD/ju0piDL14dAMGVejJpTEulqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014212; c=relaxed/simple;
	bh=qjo9JbzY5NHXF4UU8FJBeHNz28V3q/h7FpTmVyAJefU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jwcMmZFcWj6UgEqeJVKii55Fzk7HOet40cL6hkyO7XWjULRIr26HMdA+f9V3dVRy+GRr0FRFFzy+TB+sDeGxrt8EsEx0s7Orb2bbd3qrANVnOOxaRVLUtMtVr9Ul4pGvB2ECEfPrCYU3SHg5RbKCY+vnGJ5NiM2MFvd2ds83E2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHx8yZ5W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHx8yZ5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738014209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AwQUYZX5tzeTMkMRZ3TOhgSHvLVc8UK8u2KfYTJpCqA=;
	b=EHx8yZ5W8Pvem5RXSixnGWm5sA0+K45eEagbvqj4jd6MSTf6aSGQ+KiYrMsx0ciitrEgVD
	PQA9hiO0OnQ+jZW6jeNP6v+x3K6ntzz7I85o4uVlgWHQj+M4TeLzHfJ+aaR+Z6I08/uo+X
	tKY6UNJIfdk0iLbw0p71f6JBWV/k9uk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-fsHKXo8ENQ-90PMho5oTDA-1; Mon, 27 Jan 2025 16:43:28 -0500
X-MC-Unique: fsHKXo8ENQ-90PMho5oTDA-1
X-Mimecast-MFC-AGG-ID: fsHKXo8ENQ-90PMho5oTDA
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-844d5c7d664so325219439f.2
        for <fstests@vger.kernel.org>; Mon, 27 Jan 2025 13:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738014207; x=1738619007;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AwQUYZX5tzeTMkMRZ3TOhgSHvLVc8UK8u2KfYTJpCqA=;
        b=oNgumHU1MYScFx/9l4SyY2aL9Ccxp/EZri2KdeBDNqVxkDFV5/LsfLb+WjqEMf54Aq
         wDHIYvfIfQUPJcuMfemro1G+hco5ZoXQTcSj3H5SpBj7sASmHrA8HGV0MD7SA2nrqC/R
         Kti5mO10GnkdJvNo/cDUvbx0OeQT11x9blgBePsFmFYJraej/DWdpb2IY7mJsr792s8i
         OKceGdktaWoo0hWBQ8R/7yWxa1zMI2OiztCHohVBx1elXPirmbxtZY6kNbtbNmMpFYnH
         0leIuBCfwXvSCv66M8Exzq+p3RbSvQBLZPfrh7eTJeDAmGHE/esVJeILwRMpQ3z7lD4B
         QLow==
X-Gm-Message-State: AOJu0YwdzGaUyVivahP5ublLh1xOdq4ot+v0gaNktZJ+mInECrfHkLEC
	BR2Z+rQjSqknV64WsEIaVgMJpjA3DbuiCvTg49ecngvkycFlGNq8hwaHaQxLdUB9J7DyIlkzTuE
	R/qJW9Vi1KVDcuBcAdRlXQQTyoRDF3pgJAU7pUEUyQomJHQyP9SWC2l1Jud2TzB8y2/qatai/XT
	0r2kKKnSA44SkbxZR9cEhyc4aa5HddldKwK25OlhSV
X-Gm-Gg: ASbGncu0jHpzoFXVhA6Px1aXmwC6pwgnyvqBfbZTq1TX2ZqEMuYiVw3FC40uQG72uzF
	05zQSZnyFRvMiwRQ1dZFcU3CVnGqInKdAGOhAs1XLpg6RvfGiYjzLyDMXG3fBxjeZ2RHs1n5qbk
	Aw1b7AXmAf/X7EHqlRlvUwDHUpAyWreahw/JqgBQY4HFqsvw7uOgz0Q3Rsqagw6vgrRKRsExjp2
	ycNWL/CeksfkwGwHfRMJgcsU9fcvx8HGpDQZPSlTGQefEK7+5C3JouAj0roXvZPQfSI62KD0JYG
	WoZzZeYUepfxuzgDchQ+OHUbe9R9wQ3U0EEWAxve+UCK
X-Received: by 2002:a05:6602:1584:b0:843:e9c1:930b with SMTP id ca18e2360f4ac-851b65523b3mr3811472339f.14.1738014206758;
        Mon, 27 Jan 2025 13:43:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDBzCWbYLym+zeLTqT15eaGSydfaqhIRMCGaP6xYl+Q31O7niUtcN8ahDmD8rac8mHLdUbAQ==
X-Received: by 2002:a05:6602:1584:b0:843:e9c1:930b with SMTP id ca18e2360f4ac-851b65523b3mr3811470039f.14.1738014206326;
        Mon, 27 Jan 2025 13:43:26 -0800 (PST)
Received: from [10.0.0.48] (97-116-180-154.mpls.qwest.net. [97.116.180.154])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8521e0358a0sm292454539f.41.2025.01.27.13.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 13:43:25 -0800 (PST)
Message-ID: <fb7ad928-bbe9-4488-a6b7-a2786782bccd@redhat.com>
Date: Mon, 27 Jan 2025 15:43:24 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] fix vfs/utils.c for big-endian systems
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

generic/633 was failing with EINVAL on the fsxgetattr call on s390.
Looks like this is due to a failure to properly endian swap the
arguments to the syscall, so fix that, and the magic_etc compare
in expected_dummy_vfs_caps_uid() as well while we're at it.

Fixes: 0d1af68e ("generic: add fstests for idmapped mounts")
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/src/vfs/utils.c b/src/vfs/utils.c
index c1c7951c..52bb7e42 100644
--- a/src/vfs/utils.c
+++ b/src/vfs/utils.c
@@ -650,7 +650,7 @@ bool expected_dummy_vfs_caps_uid(int fd, uid_t expected_uid)
 	if (ret < 0 || ret == 0)
 		return false;
 
-	if (ns_xattr.magic_etc & VFS_CAP_REVISION_3) {
+	if (le32_to_cpu(ns_xattr.magic_etc) & VFS_CAP_REVISION_3) {
 
 		if (le32_to_cpu(ns_xattr.rootid) != expected_uid) {
 			errno = EINVAL;
@@ -673,10 +673,12 @@ int set_dummy_vfs_caps(int fd, int flags, int rootuid)
 	ns_cap_data.data[(x) >> 5].permitted |= (1 << ((x)&31))
 
 	struct vfs_ns_cap_data ns_xattr;
+	__le32 magic_etc;
 
 	memset(&ns_xattr, 0, sizeof(ns_xattr));
 	__raise_cap_permitted(CAP_NET_RAW, ns_xattr);
-	ns_xattr.magic_etc |= VFS_CAP_REVISION_3 | VFS_CAP_FLAGS_EFFECTIVE;
+	magic_etc = (VFS_CAP_REVISION_3 | VFS_CAP_FLAGS_EFFECTIVE);
+	ns_xattr.magic_etc |= cpu_to_le32(magic_etc);
 	ns_xattr.rootid = cpu_to_le32(rootuid);
 
 	return fsetxattr(fd, "security.capability",

