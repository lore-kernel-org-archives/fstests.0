Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58533 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbbEKDTK (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 10 May 2015 23:19:10 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4B3J9Fq025784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Sun, 10 May 2015 23:19:09 -0400
Received: from localhost (dhcp-12-136.nay.redhat.com [10.66.12.136])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4B3J76w011676
	for <fstests@vger.kernel.org>; Sun, 10 May 2015 23:19:08 -0400
Date: Mon, 11 May 2015 11:19:06 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: be compatible with older mkfs.xfs which has no
 v5 support
Message-ID: <20150511031906.GQ1187@dhcp-13-216.nay.redhat.com>
References: <1431258643-13620-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431258643-13620-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, May 10, 2015 at 07:50:43PM +0800, Eryu Guan wrote:
> With the change to CRCs by default, some tests are updated to call mkfs
> with "-m crc=0" option directly, and this breaks testings on older
> distros where mkfs.xfs doesn't have crc support.
> 
> Introduce a new variable to tell if mkfs.xfs supports v5 xfs and do
> tweaks in _scratch_mkfs_xfs_opts() based on it.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> 
> This is based on Dave's commit "filter: inode size output of mkfs.xfs can change"
> 
> Tested on upstream kernel with upstream xfsprogs(v5 as default) and on RHEL7(v4

Correction: tested with upstream xfsprogs with CRC default patch
applied, it was not there when I did the test.

Eryu
