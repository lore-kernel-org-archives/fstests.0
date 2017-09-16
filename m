Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38589 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751050AbdIPFIX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 16 Sep 2017 01:08:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8G55GLG124351
        for <fstests@vger.kernel.org>; Sat, 16 Sep 2017 01:08:23 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d0sn8f182-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Sat, 16 Sep 2017 01:08:22 -0400
Received: from localhost
        by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Sat, 16 Sep 2017 15:08:20 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v8G58ITY39452796
        for <fstests@vger.kernel.org>; Sat, 16 Sep 2017 15:08:18 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v8G58KfI015469
        for <fstests@vger.kernel.org>; Sat, 16 Sep 2017 15:08:21 +1000
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: [PATCH] overlay/038: fix impure xattr test
Date: Sat, 16 Sep 2017 10:39:04 +0530
In-Reply-To: <1505472448-588-1-git-send-email-amir73il@gmail.com>
References: <1505472448-588-1-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2533736.marhI9aPBx@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <eguan@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Friday, September 15, 2017 4:17:28 PM IST Amir Goldstein wrote:
> On kvm-xfstest, getfattr (2.4.43) does not return failure exit code
> when the requested xattr is not found.
> 
> Change the test to check the returned xattr value instead of exit code.

Reviewed-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Tested-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>

-- 
chandan

