Received: from szxga05-in.huawei.com ([45.249.212.191]:17133 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfALCUi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 11 Jan 2019 21:20:38 -0500
Subject: Re: [PATCH] common/scsi_debug: make sure scsi_debug been removed
 correctly
References: <20190109054845.93810-1-yangerkun@huawei.com>
 <20190109210243.GG27534@dastard>
From: yangerkun <yangerkun@huawei.com>
Message-ID: <a91e3234-9a4a-27b4-2382-683f773e892c@huawei.com>
Date: Sat, 12 Jan 2019 10:20:26 +0800
MIME-Version: 1.0
In-Reply-To: <20190109210243.GG27534@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: guaneryu@gmail.com, houtao1@huawei.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



Dave Chinner wrote on 2019/1/10 5:02:
> On Wed, Jan 09, 2019 at 01:48:45PM +0800, yangerkun wrote:
>> Case generic/108 sometimes will fail while testing ext2, and the reson
>> is that rmmod scsi_debug in _put_scsi_debug_dev may randomly fail. Now
>> add the loop to do rmmod to make sure scsi_debug can be removed
>> correctly.
> 
> Why does 'rmmod scsi_debug' randomly fail?
> 
> What bug does ext2 have that prevents the scsi debug module from
> being released and hence removed?

It's not a bug with ext2, ever been existing in ext4 too. This patch is 
a reference to 'https://gitlab.com/cryptsetup/cryptsetup.git' commit 
d7b9ed05f0931b416c33c8eb2ff1e6efa39270ff, and the reason why need this 
is that the behavior of udev cannot be speculated, so scsi_debug may 
rmmod failed since udev scan open the device and take the reference of 
module scsi_debug.

Thanks,
Kun.
> 
> Cheers,
> 
> Dave.
> 
