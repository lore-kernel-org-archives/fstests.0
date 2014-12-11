Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11231 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756536AbaLKS2M (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 11 Dec 2014 13:28:12 -0500
Message-ID: <5489E236.4060009@fb.com>
Date: Thu, 11 Dec 2014 13:28:06 -0500
From: Josef Bacik <jbacik@fb.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] fstests: change mode of test files to 0755
References: <1418318171-5892-1-git-send-email-eguan@redhat.com> <1418318171-5892-3-git-send-email-eguan@redhat.com>
In-Reply-To: <1418318171-5892-3-git-send-email-eguan@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 12/11/2014 12:16 PM, Eryu Guan wrote:
> Performed by
>
> find tests -perm 644 -name [0-9][0-9][0-9] -exec chmod 755 {} \;
>

Reviewed-by: Josef Bacik <jbacik@fb.com>

Thanks,

Josef
