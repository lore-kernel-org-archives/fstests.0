Received: from mail-vk0-f51.google.com ([209.85.213.51]:45235 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeDJAIP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Apr 2018 20:08:15 -0400
MIME-Version: 1.0
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Mon, 9 Apr 2018 19:08:13 -0500
Message-ID: <CA+EzBbCXWZZiP2jBnUQSn8LeTkav0tEJ-ra60GiVNxZK8zhLmg@mail.gmail.com>
Subject: Directory unremovable on ext4 no_journal mode
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: linux-ext4@vger.kernel.org, fstests <fstests@vger.kernel.org>
Cc: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

Hi,

We stumbled upon what seems to be a bug that makes a =E2=80=9Cdirectory
unremovable=E2=80=9D,  on ext4 when mounted with no_journal option.

A sequence of operations described below led to the following state :
=E2=80=9CA directory that was renamed, was persisted in both parent and tar=
get
directories, with the same inode number. This also means the rename
was non-atomic on storage. In addition, the renamed directory becomes
unremovable on the target with FS-error logged in dmesg.=E2=80=9D

Here are more details of the workload and the corresponding failure.

Workload :

mkdir /mnt/test/X and /mnt/test/Y
mkdir X/Z
sync()
rename X/Z   Y/Z
fsync Y
=E2=80=94-Crash now=E2=80=94-
Remount
ls X and Y (You will see Z is present in both directories X and Y, and
has same inode)
rmdir test_dir/X/Z  (This succeeds)
rmdir test_dir/Y/Z  (This fails with a FS error logged in dmesg)


Results:

rmdir: failed to remove '/mnt/test/Y/Z': Structure needs cleaning

The corresponding dmesg log has the following error message :
[66799.504124] EXT4-fs error (device cow_ram_snapshot1_0):
ext4_lookup:1576: inode #12: comm rmdir: deleted inode referenced: 14
[66799.504131] EXT4-fs (cow_ram_snapshot1_0): Remounting filesystem read-on=
ly

The sequence of operations listed above is making dir Z unremovable
from dir Y, which seems like unexpected behavior. Could you provide
more details on the reason for such behavior? We understand we run
this on no_journal mode of ext4, but would like you to verify if this
behavior is acceptable.

Do let us know if we are missing any detail here.

Thanks,
Jayashree Mohan
