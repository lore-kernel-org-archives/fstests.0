Received: from mx2.suse.de ([195.135.220.15]:39284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751958AbdI0VjY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Sep 2017 17:39:24 -0400
Subject: Re: [PATCH 1/2] generic/461: Test RWF_NOWAIT
References: <20170927191003.10099-1-rgoldwyn@suse.de>
 <20170927213454.GD3666@dastard>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Message-ID: <2292b367-9880-8e03-fe59-84dc1f2b13da@suse.de>
Date: Wed, 27 Sep 2017 16:39:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170927213454.GD3666@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>



On 09/27/2017 04:34 PM, Dave Chinner wrote:
> On Wed, Sep 27, 2017 at 02:10:02PM -0500, Goldwyn Rodrigues wrote:
>> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>
>> Tests the RWF_NOWAIT flag so the I/O returns immediately on
>> a new file, without any block allocations.
>>
>> A new program which includes the pwritev2() call is used. This allows
>> passing flags for the I/O to be performed.
> 
> Rather than write a one-off test program for this that effectively
> replicates xfs_io pread/pwrite functionality, please add RWF_NOWAIT
> flag support to xfs_io.
> 

This one off program is required because xfs_io does not support partial
writes. It tries to do that within the loop and does not return the
number of bytes written. This is required for test generic/462.

-- 
Goldwyn
